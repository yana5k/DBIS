import psycopg2
import csv
import connect
import os
import time

path_result_time = 'lab2/result_time.txt'
path_result_query = 'lab2/result_querry.csv'

#-----------------------------------------------
#Executing querry and save results
#-----------------------------------------------
def execute_query(conn):
    t0 = time.perf_counter()
    print('Start querry executing')  
      
    cur = conn.cursor()
    with open('lab2/SQL_migration_scripts/Query.sql','r', encoding='utf-8') as queryfile:
        query = array_to_string(queryfile.readlines())
    cur.execute(query)
    rows = cur.fetchall()
    cur.close()
    
    t1 = time.perf_counter()
    with open(path_result_time,"a") as ftime:
        ftime.write("Execute querry:\n")
        ftime.write(str(t1-t0)+"s\n")
    
    write_data_in_csv(rows)
    print('End querry executing')
        
def write_data_in_csv(rows):
    header = ['Region','English 2019','English 2020']
    with open(path_result_query, 'w+', newline='') as file:
        writer = csv.writer(file, delimiter=';')
        writer.writerow(header)
        for row in rows:
            writer.writerow(get_result_line_arr(row))

def get_result_line_arr(row):
    result = []
    for elem in row:
        result.append(elem)
    return result

def check_downloads(conn):
    count_rows = 'SELECT count(*) FROM "ZnoTest"'

    cur = conn.cursor()
    cur.execute(count_rows)
    conn.commit()
    result = cur.fetchall()
    cur.close()
    print('IN DB ROWS: ',result[0][0])
    time.sleep(2)
    return int(result[0][0])
#-----------------------------------------------
#Define special functions 
#----------------------------------------------- 
def array_to_string(arr):
    result = ''
    for element in arr:
        result += element
    return result

if __name__ == '__main__':
    conn = connect.connect()
    if not check_downloads(conn):
        execute_query(conn)
    connect.disconnect(conn)