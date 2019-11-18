#!/usr/bin/local/python3

# processing Google Location Data

from collections import namedtuple
import csv 
# stamp = namedtuple(
# ["timestampMs",
# "latitudeE7",
# "longitudeE7",
# "accuracy"
# ])

f = "lh.json"
attributes = ["timestampMs",
"latitudeE7",
"longitudeE7",
"accuracy"
]

def create_connection(db_file):
    """ create a database connection to the SQLite database
        specified by db_file
    :param db_file: database file
    :return: Connection object or None
    """
    conn = None
    try:
        conn = sqlite3.connect(db_file)
    except Error as e:
        print(e)
 
    return conn


def write_line(data):
    with open('lh.csv', 'a') as the_file:
        the_file.write(','.join(data)+'\n')

if __name__ == "__main__":
    
    with open("lh.json") as infile:

        l = []
        c = 0
        write_line(attributes)
        for line in infile:
            if attributes[c] in line:
                n = line.split(':')
                n = n[-1].strip().strip(', ')
                l.append(n)
                if len(l) > 3:
                    write_line(l)
                    l = []
                    
                c =  (c + 1)%4
            
        
