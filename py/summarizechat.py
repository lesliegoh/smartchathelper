import re
import argparse
import mysql.connector
import pandas as pd

from py.class_text_summarization import TextSummarization 

# get arguments
ap = argparse.ArgumentParser()
ap.add_argument("account", help="the account ID of the chat")

args = vars(ap.parse_args())
accountID = args["account"]

# open mysql connection
mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="password",
    database="smartchathelper",
    auth_plugin='mysql_native_password'
)

data_chat = pd.read_sql('SELECT * FROM messages WHERE isDeleted = 0 AND isPicture = 0 AND isFile = 0 AND accountID_FK = ' + accountID + ' ORDER BY dateCreated ASC', mydb)
rows = data_chat['message'].to_numpy()

# clean the raw html
CLEANR = re.compile('<.*?>|&([a-z0-9]+|#[0-9]{1,6}|#x[0-9a-f]{1,6});')

def cleanhtml(raw_html):

  # remove all user references
  raw_html = re.sub(r'<a data-id.*?</a>','', raw_html)
  cleantext = re.sub(CLEANR, '', raw_html)
  return cleantext

# preprocess sql chat data
sentences = []

for row in rows:
    clean_row = cleanhtml(row)
    clean_row = clean_row.split(". ")

    for sentence in clean_row:       
        sentences.append(sentence)

# get chat summary
ts = TextSummarization()

chat_summary = ts.generate_summary(sentences, 3)
print(chat_summary)