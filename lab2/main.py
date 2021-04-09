import psycopg2
import csv
import connect
import os
import time

path_result_time = 'lab-2/result_time.txt'
path_result_query = 'lab-2/result_querry.csv'

#-----------------------------------------------
#section for working with DB
#-----------------------------------------------  
def create_DB_tables(drop_table, conn):
    print('Start table creation')
    t0 = time.perf_counter()
    cur = conn.cursor()
    
    with open('Drop Tables.sql', 'r') as dropfile:
        drop = array_to_string(dropfile.readlines())
    with open('CreateTables.sql', 'r') as createfile:
        create = array_to_string(createfile.readlines())
    
    if not (drop_table):
        cur.execute(drop)
        conn.commit()
    cur.execute(create)
    conn.commit()
    cur.close()
    t1 = time.perf_counter()
    with open(path_result_time,"w") as ftime:
        ftime.write("Creating Tables: \n")
        ftime.write(str(t1-t0)+" s\n")
    print('End table creation')
    
#-----------------------------------------------
#Migrate data from results table
#-----------------------------------------------            
def migrate_data(conn):
    t0 = time.perf_counter()
    print('Start migrating')  
      
    cur = conn.cursor()
    with open('InsertFromResultsTable.sql','r', encoding='utf-8') as migratefile:
        migrate = array_to_string(migratefile.readlines())
    cur.execute(migrate)
    conn.commit()
    cur.close()
    
    print('End migrating')
    t1 = time.perf_counter()
    with open(path_result_time,"a") as ftime:
        ftime.write("Migrating data:\n")
        ftime.write(str(t1-t0)+" s\n")

#-----------------------------------------------
#Executing querry and save results
#-----------------------------------------------
def execute_query(conn):
    t0 = time.perf_counter()
    print('Start querry executing')  
      
    cur = conn.cursor()
    with open('lab-2/Query.sql','r', encoding='utf-8') as queryfile:
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
    # create_DB_tables(1,conn)
    # migrate_data(conn)
    execute_query(conn)
    connect.disconnect(conn)