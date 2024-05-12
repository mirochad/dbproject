from datetime import datetime, timedelta
from faker import Faker #type: ignore 
import random

fake = Faker()

def generate_rating_data(num_records):
    rating_data = []
    for _ in range(num_records):
        number = random.randint(1, 5)

        rating_data.append({
            'table_name': 'rating',
            'number': number
        })
    return rating_data

def generate_episode_data(num_episodes_per_year, num_years):
    episode_data = []
    start_year = 2022  # Αρχική χρονιά
    for year in range(start_year, start_year + num_years):
        start_date = datetime(year, 1, 1)
        for episode_number in range(1, num_episodes_per_year + 1):
            name = f"Episode {episode_number} - {year}"
            random_days = random.randint(0, 364)  # Τυχαίος αριθμός ημερών
            date = (start_date + timedelta(days=random_days)).date()
            image_uri = fake.image_url()
            episode_data.append({
                'table_name': 'episode',
                'name': name,
                'date': date,
                'image_uri': image_uri
            })
    return episode_data

def generate_insert_queries(data):
    queries = []
    for item in data:
        table_name = item['table_name']
        del item['table_name']  # Διαγράφουμε το πεδίο table_name από το λεξικό
        keys = ', '.join(item.keys())
        values = "', '".join(str(value) for value in item.values())
        query = f"INSERT INTO {table_name} ({keys}) VALUES ('{values}');"
        queries.append(query)
    return queries



def write_to_file(filename, data):
    with open(filename, 'w', encoding='utf-8') as file:
        for item in data:
            file.write("%s\n" % item)

num_records_rating = 0
num_records_episodes_per_year = 0
num_records_year = 0


rating_data = generate_rating_data(num_records_rating)
episode_data = generate_episode_data(num_records_episodes_per_year, num_records_year)

write_to_file('dummy_data2.txt', generate_insert_queries(rating_data + episode_data))