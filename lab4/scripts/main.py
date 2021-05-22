from settings import Connect
from bson.son import SON
import csv
import time

Source_files = 'Odata{year}File.csv'
time_result = 'lab4/results/time_result.txt'
query_result = 'lab4/results/query_result.csv'
step = 10000
json_list = []


def data_to_DB(collection):
    t0 = time.perf_counter()
    for year in [2019,2020]:
        header = []
        print(str(year) + ' file')
        print("-"*100)
        max_row_number = step
        with open(Source_files.format(year=year), encoding='cp1251') as f:
            header = f.readline().replace('"','')[:-1].split(';')
            header.append('year')

            data = csv.reader(f,delimiter=';',quotechar='"',quoting=csv.QUOTE_ALL)   
            i = 1

            IN_DB_ROWS = collection.count_documents({"year" : year})
            if IN_DB_ROWS:
                i += IN_DB_ROWS
                max_row_number = IN_DB_ROWS + step
            
            for row in data:
                # if i <= 100000:                    
                if IN_DB_ROWS < i:
                    row.append(year)
                    i, max_row_number = line_to_json_list(header, row, i, step, max_row_number,year, collection) 
                else:
                    if IN_DB_ROWS == i and not len(json_list):
                        print(i, 'line is already in DB')
                        time.sleep(3)
                    i += 1 
                # else:
                #     break       
        if len(json_list):
            upload_json_to_db(collection,json_list)
        
        print('End {yearFile} file to DB\nIn Collection {lines} lines'.format(yearFile = year,lines = collection.count_documents({})))
        print('='*100)
    t1 = time.perf_counter()
    write_time_results(t0,t1,'Upload Data to database')


def line_to_json_list(header, row, i, step, max_row_number,year, collection):
    print(f'Year - {year}; Line {i}')
    line_json = { h_value : "-" for h_value in header }
    for j in range(len(header)):
        if clean_csv_value(row[j]) == row[j]:
            line_json[header[j]] = row[j]
        else:
            line_json[header[j]] = clean_csv_value(row[j])

    json_list.append(line_json)
    i += 1
    if max_row_number < i:
        print("-"*100)
        print(f'Uploading to DB next {step} lines. . .')
        max_row_number += step
        upload_json_to_db(collection,json_list)
    return i, max_row_number


def upload_json_to_db(collection,json_list):
    collection.insert_many(json_list)
    time.sleep(3)
    json_list.clear() 

def clean_csv_value(value):
    if value == 'null':
        return value
    try:
        res = int(float(value.replace(',', '.')))
        return res
    except:
        try:
            res = float(value.replace(',', '.'))
            return res
        except:
            return value

def write_time_results(t0,t1,Message):
    with open(time_result,"a") as ftime:
        ftime.write(f'\n{Message}:\n')
        ftime.write(str(t1-t0)+"s\n")

if __name__ == '__main__':
    t0 =  time.perf_counter()
    connection = Connect.get_connection()
    db = connection['Lab4']
    # db.drop_collection('ZNO')
    collection = db['ZNO']
    t1 = time.perf_counter()
    with open(time_result,"w+") as ftime:
        ftime.write('Connected to database:\n')
        ftime.write(str(t1-t0)+"s\n")
    print("IN_DB - ", collection.count_documents({}))
    print('='*100)
    

    data_to_DB(collection)
    # print(collection.find_one())
    t0 = time.perf_counter()
    header = ["Region","Year", "Max English Results"]
    query_results_list = collection.aggregate([
            {
                "$match" : { 
                                "engTestStatus" :  'Зараховано' 
                            }
            },
            {
                "$group" : { 
                                "_id" : {
                                            "region" : "$REGNAME",
                                            "year" : "$year",
                                        },
                                "EngMaxResults": { "$max": "$engBall100" }
                            }
            },
            {
                "$sort" : { "_id.region": 1, "_id.year": 1 }
            }])

    data = []
    for el in query_results_list:
        row = [el["_id"]["region"], el["_id"]["year"], el["EngMaxResults"]]
        data.append(row)

    with open(query_result, 'w', encoding='utf-8') as res_file:
        result_writer = csv.writer(res_file, delimiter=';')
        result_writer.writerow(header)
        result_writer.writerows(data)
    t1 = time.perf_counter()
    write_time_results(t0,t1, 'Query')