import os,json
from sys import argv

def create_insert_statements(json_name,table_name,table_column_names,column_names):
    path_to_json = 'dataset/'
    parsed_file_path = 'Insert_Scripts/'
    column_list = column_names.split(",")
    table_column_list = table_column_names.split(",")
    insert_list = set()
    with open(path_to_json + json_name,encoding = 'UTF-8') as json_file: #open file
        data = json.load(json_file) # load json
        dataitems = data["results"][0]["items"]
        dataitemsstr = json.dumps(data["results"][0]["items"])
        for i in range(len(dataitems)):#loop over json values
            makepairs = json.loads(dataitemsstr)[i]
            pairs = makepairs.items() # make key value pairs
            insert_str = 'INSERT INTO '+table_name+' ('# start of the insert string
            for k in table_column_list:
                insert_str = insert_str + k + ','; # table name added to insert string
            insert_str = insert_str[:-1] + ') VALUES ('
            for j in column_list:
                for key,value in pairs:
                    if key.lower()==j.lower():
                        strvalue = str(value)
                        strvalue = strvalue.replace('\'','\'\'') # taking care of single quote
                        insert_str = insert_str + '\'' + strvalue + '\'' + ',' # values added to insert statement string
            insert_str = insert_str[:-1] + ');' # removing extra comma
            insert_list.add(insert_str);
    
    # for insert_statement in insert_list:
    #     print(insert_statement)
    insert_script = open(parsed_file_path + table_name + '.sql', 'w+',encoding='UTF-8')
    for insert_statement in insert_list:
        insert_script.write(insert_statement) # final insert strings being written to the output file
        insert_script.write("\n")
    insert_script.close()

if __name__ == "__main__":
    create_insert_statements(argv[1],argv[2],argv[3],argv[4]) # calling the parser logic with command line arguments
