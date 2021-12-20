import os,json
from sys import argv

def remove_redundant_keys(json_name,collection_name,collection_column_names):
    path_to_json = 'dataset/'
    parsed_file_path = 'Collection_JSONS/'
    collection_column_list = collection_column_names.split(",")
    normalized_json_list = [] # here normalized means without redundant columns
    with open(path_to_json+json_name, encoding = 'UTF-8') as json_file_name:
        data = json.load(json_file_name)
        dataitems = data['results'][0]['items']
        dataitemsstr = json.dumps(data["results"][0]["items"])
        for i in range(len(dataitems)):
            makepairs = json.loads(dataitemsstr)[i]
            pairs = makepairs.items()
            needed_name_value_pair = {}
            for j in collection_column_list:
                for key,value in pairs:
                    if key.lower() == j.lower() and str(value) != "" and str(value)!='':
                        needed_name_value_pair[key.lower()]=str(value)
            
            if needed_name_value_pair not in normalized_json_list:
                normalized_json_list.append(needed_name_value_pair)
        
    collection_json_writer = open(parsed_file_path + collection_name + '.json', 'w+',encoding='UTF-8')
    collection_json = json.dumps(normalized_json_list,indent=4,ensure_ascii=False)
    collection_json_writer.write(collection_json)
    collection_json_writer.close()

def assign_id(collection_name,primary_keys):
    parsed_file_path = 'Collection_JSONS/'
    primary_key_list = primary_keys.split(",")
    data = []
    with open(parsed_file_path+collection_name+'.json',encoding = 'UTF-8') as collection_file:
        data = json.load(collection_file)
        for data_item in data:
            primary_key_string=""
            for primary_key in primary_key_list:
                primary_key_string += str(data_item[primary_key])
            primary_key_string = primary_key_string.lower()
            data_item["_id"]=hash(primary_key_string)

    collection_json_writer = open(parsed_file_path + collection_name + '.json', 'w+',encoding='UTF-8')
    collection_json = json.dumps(data,indent=4,ensure_ascii=False)
    collection_json_writer.write(collection_json)
    collection_json_writer.close()

def embed_child_json_to_parent(parent_json,child_json,primary_keys,foreign_keys,keys_to_embed):
    parsed_file_path = 'Collection_JSONS/'
    embed_key = child_json.replace('.json','')
    primary_key_list = primary_keys.split(",")
    foreign_key_list = foreign_keys.split(",")
    list_of_keys_to_embed = keys_to_embed.split(",")
    
    with open(parsed_file_path+parent_json,encoding="utf-8") as parent_collection:
        parent_data = json.load(parent_collection)

    with open(parsed_file_path+child_json,encoding="utf-8") as child_collection:
        child_data = json.load(child_collection)
    
    for parent_record in parent_data:
        for child_record in child_data:
            is_matching_pkey = True
            for i in range(len(primary_key_list)):
                if parent_record[primary_key_list[i]] != child_record[foreign_key_list[i]]:
                    is_matching_pkey = False
                    break
            
            if is_matching_pkey == True:
                record_to_embed = {}
                for key in list_of_keys_to_embed:
                    if key in child_record:
                        record_to_embed[key]=child_record[key]
                if embed_key not in parent_record:
                    parent_record[embed_key] = []
                parent_record[embed_key].append(record_to_embed)

    collection_json_writer = open(parsed_file_path + parent_json, 'w+',encoding='UTF-8')
    collection_json = json.dumps(parent_data,indent=4,ensure_ascii=False)
    collection_json_writer.write(collection_json)
    collection_json_writer.close()

def create_reference(parent_json,child_json,primary_keys,foreign_keys,referred_field_name):
    parsed_file_path = 'Collection_JSONS/'
    primary_key_list = primary_keys.split(",")
    foreign_key_list = foreign_keys.split(",")

    with open(parsed_file_path+parent_json,encoding="utf-8") as parent_collection:
        parent_data = json.load(parent_collection)

    with open(parsed_file_path+child_json,encoding="utf-8") as child_collection:
        child_data = json.load(child_collection)
    
    for parent_record in parent_data:
        for child_record in child_data:
            is_matching_pkey = True
            for i in range(len(primary_key_list)):
                if (foreign_key_list[i] not in child_record) or (child_record[foreign_key_list[i]]!=parent_record[primary_key_list[i]]):
                    is_matching_pkey = False
                    break
            
            if is_matching_pkey == True:
                if referred_field_name not in parent_record:
                    parent_record[referred_field_name] = []
                parent_record[referred_field_name].append(child_record["_id"])

    collection_json_writer = open(parsed_file_path + parent_json, 'w+',encoding='UTF-8')
    collection_json = json.dumps(parent_data,indent=4,ensure_ascii=False)
    collection_json_writer.write(collection_json)
    collection_json_writer.close()

if __name__ == '__main__':
    if argv[1] == 'remove_redundant_keys':
        remove_redundant_keys(argv[2],argv[3],argv[4])
    
    if argv[1] == 'assign_id':
        assign_id(argv[2],argv[3])
    
    if argv[1] == 'embed_json':
        embed_child_json_to_parent(argv[2],argv[3],argv[4],argv[5],argv[6])

    if argv[1] == 'create_reference':
        create_reference(argv[2],argv[3],argv[4],argv[5],argv[6])
    
    #remove_redundant_keys("airport.json","airport","iatacode,name,country_code,city,airport_province,island,latitude,longitude,gmtOffset")
    # CITY
	# remove_redundant_keys("city.json", "CITY", "NAME,COUNTRY,PROVINCE,ELEVATION,LATITUDE,LONGITUDE")

	# CITY_LOCALNAME
	# remove_redundant_keys("citylocalname.json", "CITY_LOCALNAME", "CITY,COUNTRY,PROVINCE,LOCALNAME")

	# CITY_OTHERNAME
	# remove_redundant_keys("cityothername.json", "CITY_OTHERNAME", "CITY,COUNTRY,PROVINCE,OTHERNAME")

	# CITY_POPULATION
	# remove_redundant_keys("citypopulations.json","CITY_POPULATIONS","CITY,PROVINCE,COUNTRY,POPULATION,YEAR")

	# embed_child_json_to_parent("CITY.json", "CITY_LOCALNAME.json", "name,country,province", "city,country,province", "localname")
	# embed_child_json_to_parent("CITY.json", "CITY_OTHERNAME.json", "name,country,province", "city,country,province","othername")
	# embed_child_json_to_parent("CITY.json", "CITY_POPULATIONS.json", "name,country,province", "city,country,province","population,year")

    # parsed_file_path = 'Collection_JSONS/'
    # with open('Collection_JSONS/airport.json',encoding = 'UTF-8') as collection_file:
    #     data = json.load(collection_file)
    #     print(data[0]["iatacode"])
    #     print(len(data))
    # assign_id('airport','iatacode')