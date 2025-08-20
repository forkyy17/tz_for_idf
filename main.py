import requests
import clickhouse_connect
import json
import time



def download_austronauts_data(max_retries = 5):
    url = 'http://api.open-notify.org/astros.json'
    for attempt in range(max_retries):
        try:
            response = requests.get(url, timeout=10)
            if response.status_code == 200:
                return response.json()
            
            elif response.status_code == 429:
                if max_retries - 1 > attempt:
                    wait_time = (2 ** attempt)
                    time.sleep(wait_time)
            else:
                if max_retries - 1 > attempt:
                    wait_time = (2 ** attempt)
                    time.sleep(wait_time)

        except requests.exceptions.RequestException: 
            if max_retries - 1 > attempt:
                wait_time = (2 ** attempt)
                time.sleep(wait_time)
            
    raise Exception(f"Не удалось скачать данные после {max_retries} попыток")

def insert_to_clickhouse(client, data):
    """Вставка данных в ClickHouse"""
    raw_json = json.dumps(data)
    client.command(f"""
        INSERT INTO default.raw_data (raw_json, _inserted_at)
        VALUES ('{raw_json}', now64(3))
    """)

def main():
    try:
        client = clickhouse_connect.get_client(
            host = 'localhost',
            port = 8123,
            user = 'idftask',
            password='idftask'
        )

        data = download_austronauts_data()

        insert_to_clickhouse(client, data)

        print("Задача выполнена успешно!")
    except Exception as e:
        print(f"Ошибка: {e}")
    finally:
        if 'client' in locals():
            client.close()
    
if __name__ == "__main__":
    main()
