Информация для запуска проекта:

1) Запуск ClickHouse

Из корня проекта:

docker-compose up -d

2) Создание таблиц в ClickHouse
   
Из корня проекта:

cat scripts/01_create_raw_table.sql | docker exec -i idf-task-clickhouse-1 clickhouse-client -u idftask --password idftask

cat scripts/02_create_people_table.sql | docker exec -i idf-task-clickhouse-1 clickhouse-client -u idftask --password idftask

cat scripts/03_create_people_mv.sql   | docker exec -i idf-task-clickhouse-1 clickhouse-client -u idftask --password idftask

3) Подготовка Python окружения и загрузка данных
   
Из корня проекта:

python3.11 -m venv .venv

source .venv/bin/activate

pip install -r requirements.txt

python main.py

4) Запуск dbt модели и тестов
   
Из директории dbt_project:

cd dbt_project

export DBT_PROFILES_DIR=$(pwd)

dbt run --select people_in_space_aggregated

dbt test --select people_in_space_aggregated
