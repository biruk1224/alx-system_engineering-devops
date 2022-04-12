#!/usr/bin/python3
"""
Write a Python script that, using this REST API,
for a given employee ID, returns information about
his/her TODO list progress
"""
import requests
import sys


if __name__ == '__main__':

    id_c = sys.argv[1]
    task_title = []
    complete = 0
    total_task = 0
    url_user = "https://jsonplaceholder.typicode.com/users/" + id_c
    res = requests.get(url_user).json()
    name = res.get('name')
    url_task = "https://jsonplaceholder.typicode.com/todos/"
    res_task = requests.get(url_task).json()
    for i in res_task:
        if i.get('userId') == int(id_c):
            if i.get('completed') is True:
                task_title.append(i['title'])
                complete += 1
            total_task += 1
    print("Employee {} is done with tasks({}/{}):"
          .format(name, complete, total_task))
    for x in task_title:
        print("\t {}".format(x))
