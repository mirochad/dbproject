from datetime import datetime, timedelta
from faker import Faker #type: ignore 
import random

fake = Faker()

def generate_users_data(num_records):
    users_data = []
    for _ in range(num_records):
        first_name = fake.first_name()
        last_name = fake.last_name()
        phone = fake.phone_number()
        date_of_birth = fake.date_of_birth(minimum_age=18, maximum_age=90)
        username = fake.user_name()
        password = fake.password()
        experience_years = random.randint(0, 30)
        image_uri = fake.image_url()
        qualification_id = random.randint(1,5)
        
        users_data.append({
            'table_name': 'users',
            'first_name': first_name,
            'last_name': last_name,
            'phone': phone,
            'date_of_birth': date_of_birth,
            'username': username,
            'password': password,
            'experience_years': experience_years,
            'image_uri': image_uri,
            'qualification_id': qualification_id
        })
    return users_data

def generate_recipe_data(num_records):
    recipe_data = []
    for _ in range(num_records):
        category = random.choice(['Cooking', 'Pastry'])
        difficulty = random.randint(1, 5)
        name = fake.word()
        description = fake.sentence()
        tips = fake.sentence()
        preparation_time = random.randint(5, 120)
        cooking_time = random.randint(5, 120)
        portions = random.randint(1, 3)
        image_uri = fake.image_url()
        cuisine_id = random.randint(1, 10)
        users_id = random.randint(1, 50)
        
        recipe_data.append({
            'table_name': 'recipe',
            'category': category,
            'difficulty': difficulty,
            'name': name,
            'description': description,
            'tips': tips,
            'preparation_time': preparation_time,
            'cooking_time': cooking_time,
            'portions': portions,
            'image_uri': image_uri,
            'cuisine_id': cuisine_id,
            'users_id': users_id
        })
    return recipe_data

def generate_tag_data(num_records):
    tag_data = []
    for _ in range(num_records):
        name = fake.word()
        
        tag_data.append({
            'table_name': 'tag',
            'name': name
        })
    return tag_data

def generate_equipment_data(num_records):
    equipment_data = []
    for _ in range(num_records):
        name = fake.word()
        instruction = fake.sentence()
        image_uri = fake.image_url()
        
        equipment_data.append({
            'table_name': 'equipment',
            'name': name,
            'instruction': instruction,
            'image_uri': image_uri
        })
    return equipment_data

def generate_step_data(num_recipes):
    step_data = []
    for recipe_id in range(1, num_recipes + 1):
        numrand = random.randint(3,10)
        for order in range(1, numrand):
            instruction = fake.sentence()
            step_data.append({
                'table_name': 'step',
                'recipe_id': recipe_id,
                'orders': order,
                'instruction': instruction
            })
    return step_data


def generate_ingredient_data(num_records):
    ingredient_data = []
    for _ in range(num_records):
        name = fake.word()
        amount_exact = random.randint(1, 1000)  
        amount_not_exact = fake.word()  
        image_uri = fake.image_url()
        food_group_id = random.randint(1, 3)
        
        ingredient_data.append({
            'table_name': 'ingredient',
            'name': name,
            'amount_exact': amount_exact,
            'amount_not_exact': amount_not_exact,
            'image_uri': image_uri,
            'food_group_id': food_group_id
        })
    return ingredient_data

def generate_nutritional_info_data(num_records):
    nutritional_info_data = []
    for recipe_id in range(1, num_records + 1):
        protein = fake.random_int(min=1, max=100)  
        carb = fake.random_int(min=1, max=100)  
        fat = fake.random_int(min=1, max=100) 

        nutritional_info_data.append({
            'table_name': 'nutritional_info',
            'recipe_id': recipe_id,
            'protein': protein,
            'carb': carb,
            'fat': fat
        })
    return nutritional_info_data

def generate_rec_meal_time_data(num_recipes, num_meal_times):
    rec_meal_time_data = []
    for recipe_id in range(1, num_recipes + 1):
        num_meal_times_per_recipe = random.randint(1, num_meal_times)
        meal_time_ids = random.sample(range(1, num_meal_times + 1), num_meal_times_per_recipe)
        rec_meal_time_data.extend([{
            'table_name': 'rec_meal_time',
            'recipe_id': recipe_id,
            'meal_time_id': meal_time_id
        } for meal_time_id in meal_time_ids])
    return rec_meal_time_data

def generate_expertise_data(num_users, num_cuisines):
    expertise_data = []
    for user_id in range(1, num_users + 1):
        num_cuisines_per_user = random.randint(1, num_cuisines)
        cuisine_ids = random.sample(range(1, num_cuisines + 1), num_cuisines_per_user)
        expertise_data.extend([{
            'table_name': 'expertise',
            'users_id': user_id,
            'cuisine_id': cuisine_id
        } for cuisine_id in cuisine_ids])
    return expertise_data

def generate_rec_tag_data(num_recipes, num_tags):
    rec_tag_data = []
    for recipe_id in range(1, num_recipes + 1):
        num_tags_per_recipe = random.randint(1, num_tags)
        tag_ids = random.sample(range(1, num_tags + 1), num_tags_per_recipe)
        rec_tag_data.extend([{
            'table_name': 'rec_tag',
            'recipe_id': recipe_id,
            'tag_id': tag_id
        } for tag_id in tag_ids])
    return rec_tag_data

def generate_rec_equipment_data(num_recipes, num_equipment):
    rec_equipment_data = []
    for recipe_id in range(1, num_recipes + 1):
        num_equipment_per_recipe = random.randint(1, num_equipment)
        equipment_ids = random.sample(range(1, num_equipment + 1), num_equipment_per_recipe)
        rec_equipment_data.extend([{
            'table_name': 'rec_equipment',
            'recipe_id': recipe_id,
            'equipment_id': equipment_id
        } for equipment_id in equipment_ids])
    return rec_equipment_data

def generate_rec_ingredient_data(num_recipes, num_ingredients):
    rec_ingredient_data = []
    for recipe_id in range(1, num_recipes + 1):
        num_ingredients_per_recipe = random.randint(1, num_ingredients)
        ingredient_ids = random.sample(range(1, num_ingredients + 1), num_ingredients_per_recipe)
        rec_ingredient_data.extend([{
            'table_name': 'rec_ingredient',
            'recipe_id': recipe_id,
            'ingredient_id': ingredient_id
        } for ingredient_id in ingredient_ids])
    return rec_ingredient_data


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

# Πόσα δεδομένα θέλετε να δημιουργήσετε για κάθε πίνακα
num_records_users = 100
num_records_recipe = 100
num_records_tag = 10
num_records_equipment = 10
num_records_ingredient = 100
num_records_nutritional_info = 100
num_records_meal_time = 5
num_records_cuisine = 10

# Δημιουργία δεδομένων για κάθε πίνακα
users_data = generate_users_data(num_records_users)
recipe_data = generate_recipe_data(num_records_recipe)
tag_data = generate_tag_data(num_records_tag)
equipment_data = generate_equipment_data(num_records_equipment)
step_data = generate_step_data(num_records_recipe)
ingredient_data = generate_ingredient_data(num_records_ingredient)
nutritional_info_data = generate_nutritional_info_data(num_records_recipe)
rec_meal_time_data = generate_rec_meal_time_data(num_records_recipe, num_records_meal_time)
expertise_data = generate_expertise_data(num_records_users, num_records_cuisine)
rec_tag = generate_rec_tag_data(num_records_recipe, num_records_tag)
rec_equipment = generate_rec_equipment_data(num_records_recipe, num_records_equipment)
rec_ingredient = generate_rec_ingredient_data(num_records_recipe, num_records_ingredient)

# Προσθήκη των insert queries στο αρχείο
write_to_file('dummy_data1.txt', generate_insert_queries(users_data + recipe_data + tag_data + equipment_data + step_data + ingredient_data + nutritional_info_data + rec_meal_time_data + expertise_data + rec_tag + rec_equipment + rec_ingredient))
