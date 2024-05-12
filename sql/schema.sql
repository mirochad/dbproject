CREATE TABLE IF NOT EXISTS qualification (
    qualification_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    ranks INT NOT NULL,
    PRIMARY KEY (qualification_id)
);

CREATE TABLE IF NOT EXISTS users (
    users_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    age INT NOT NULL,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    experience_years INT NOT NULL,
    image_uri VARCHAR(255),
    qualification_id INT UNSIGNED,
    PRIMARY KEY (users_id),
    FOREIGN KEY (qualification_id) REFERENCES qualification(qualification_id)
);

CREATE TABLE IF NOT EXISTS cuisine (
    cuisine_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (cuisine_id)
);

CREATE TABLE IF NOT EXISTS expertise (
    users_id INT UNSIGNED,
    cuisine_id INT UNSIGNED,
    PRIMARY KEY (users_id, cuisine_id),
    FOREIGN KEY (users_id) REFERENCES users(users_id),
    FOREIGN KEY (cuisine_id) REFERENCES cuisine(cuisine_id)
);

CREATE TABLE IF NOT EXISTS food_group (
    food_group_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    image_uri VARCHAR(255),
    PRIMARY KEY (food_group_id)
);

CREATE TABLE IF NOT EXISTS theme (
    theme_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    image_uri VARCHAR(255),
    PRIMARY KEY (theme_id)
);

CREATE TABLE IF NOT EXISTS recipe (
    recipe_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    category ENUM('Cooking', 'Pastry'),
    difficulty INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    tips VARCHAR(255),
    preparation_time INT,
    cooking_time INT,
    total_time INT NOT NULL,
    portions INT,
    image_uri VARCHAR(255),
    cuisine_id INT UNSIGNED,
    users_id INT UNSIGNED,
    theme_id INT UNSIGNED,
    PRIMARY KEY (recipe_id),
    FOREIGN KEY (cuisine_id) REFERENCES cuisine(cuisine_id),
    FOREIGN KEY (users_id) REFERENCES users(users_id),
    FOREIGN KEY (theme_id) REFERENCES theme(theme_id)
);

CREATE TABLE IF NOT EXISTS meal_time (
    meal_time_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR (255) NOT NULL,
    PRIMARY KEY (meal_time_id)
);

CREATE TABLE IF NOT EXISTS rec_meal_time (
    recipe_id INT UNSIGNED,
    meal_time_id INT UNSIGNED,
    PRIMARY KEY (recipe_id, meal_time_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id),
    FOREIGN KEY (meal_time_id) REFERENCES meal_time(meal_time_id)
);

CREATE TABLE IF NOT EXISTS tag (
    tag_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (tag_id)
);

CREATE TABLE IF NOT EXISTS rec_tag (
    recipe_id INT UNSIGNED,
    tag_id INT UNSIGNED,
    PRIMARY KEY (recipe_id, tag_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id),
    FOREIGN KEY (tag_id) REFERENCES tag(tag_id)
);

CREATE TABLE IF NOT EXISTS equipment (
    equipment_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    instruction VARCHAR(255),
    image_uri VARCHAR(255),
    PRIMARY KEY (equipment_id)
);

CREATE TABLE IF NOT EXISTS rec_equipment (
    recipe_id INT UNSIGNED,
    equipment_id INT UNSIGNED,
    PRIMARY KEY (recipe_id, equipment_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id),
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)
);

CREATE TABLE IF NOT EXISTS step (
    step_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    orders INT UNSIGNED NOT NULL,
    instruction VARCHAR(255) NOT NULL,
    recipe_id INT UNSIGNED,
    PRIMARY KEY (step_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ingredient (
    ingredient_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    amount_exact INT UNSIGNED,
    amount_not_exact VARCHAR(255), 
    image_uri VARCHAR(255),
    food_group_id INT UNSIGNED,
    PRIMARY KEY (ingredient_id),
    FOREIGN KEY (food_group_id) REFERENCES food_group(food_group_id)
);

CREATE TABLE IF NOT EXISTS rec_ingredient (
    recipe_id INT UNSIGNED,
    ingredient_id INT UNSIGNED,
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredient(ingredient_id)
);

CREATE TABLE IF NOT EXISTS nutritional_info (
    nutritional_info_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    protein INT NOT NULL,
    carb INT NOT NULL,
    fat INT NOT NULL,
    total_calories INT GENERATED ALWAYS AS (4 * protein + 4 * carb + 9 * fat) STORED,
    recipe_id INT UNSIGNED,
    FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id) ON DELETE CASCADE,
    PRIMARY KEY (nutritional_info_id)
);

CREATE TABLE IF NOT EXISTS item (
    item_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    recipe_id INT UNSIGNED,
    PRIMARY KEY (item_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id)
);

CREATE TABLE IF NOT EXISTS cook (
    cook_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    item_id INT UNSIGNED,
    users_id INT UNSIGNED,
    PRIMARY KEY (cook_id),
    FOREIGN KEY (item_id) REFERENCES item(item_id),
    FOREIGN KEY (users_id) REFERENCES users(users_id)
);

CREATE TABLE IF NOT EXISTS episode (
    episode_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    image_uri VARCHAR(255),    
    PRIMARY KEY (episode_id)
);

CREATE TABLE IF NOT EXISTS item_episode (
    item_id INT UNSIGNED,
    episode_id INT UNSIGNED,
    PRIMARY KEY (item_id, episode_id),
    FOREIGN KEY (item_id) REFERENCES item(item_id),
    FOREIGN KEY (episode_id) REFERENCES episode(episode_id)
);

CREATE TABLE IF NOT EXISTS episode_users (
    episode_id INT UNSIGNED,
    users_id INT UNSIGNED,
    PRIMARY KEY (episode_id, users_id),
    FOREIGN KEY (episode_id) REFERENCES episode(episode_id),
    FOREIGN KEY (users_id) REFERENCES users(users_id)
);

CREATE TABLE IF NOT EXISTS admin (
    admin_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    users_id INT UNSIGNED,
    FOREIGN KEY (users_id) REFERENCES users(users_id) ON DELETE CASCADE,
    PRIMARY KEY (admin_id)
);

CREATE TABLE IF NOT EXISTS chef (
    chef_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    users_id INT UNSIGNED,
    FOREIGN KEY (users_id) REFERENCES users(users_id) ON DELETE CASCADE,
    PRIMARY KEY (chef_id)
);

CREATE TABLE IF NOT EXISTS judge (
    judge_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    users_id INT UNSIGNED,
    FOREIGN KEY (users_id) REFERENCES users(users_id) ON DELETE CASCADE,
    PRIMARY KEY (judge_id)
);

CREATE TABLE IF NOT EXISTS rating (
    rating_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    number INT UNSIGNED NOT NULL,
    chef_id INT UNSIGNED,
    judge_id INT UNSIGNED,
    FOREIGN KEY (chef_id) REFERENCES chef(chef_id),
    FOREIGN KEY (judge_id) REFERENCES judge(judge_id),
    PRIMARY KEY (rating_id) 
);

DELIMITER $$
CREATE TRIGGER calculate_age BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    SET NEW.age = YEAR(CURDATE()) - YEAR(NEW.date_of_birth);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER calculate_total_time BEFORE INSERT ON recipe
FOR EACH ROW
BEGIN
    SET NEW.total_time = NEW.preparation_time + NEW.cooking_time;
END$$
DELIMITER ;
