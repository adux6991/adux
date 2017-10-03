import requests
import smtplib
import time
import traceback
from datetime import datetime
from email.mime.text import MIMEText  
from bs4 import BeautifulSoup

seconds = 1000
positive = ['硬盘']
negative = ['求']
maxpid = 0

payload = {
        'username' : '',
        'password' : '',
        't' : '8eb0c8e0ec25b81048cab55a9f3c9f36'
}


sender = 'x@pku.edu.cn'  
receiver = 'x@pku.edu.cn' 
subject = 'There is a card!'
smtpserver = 'mail.pku.edu.cn'  
username = 'x@pku.edu.cn'
password = ''

try:
    while True:
        mailcontent = ''

        session = requests.session()
        logged = session.post('https://bbs.pku.edu.cn/v2/ajax/login.php', payload).text
        if 'true' not in logged:
            mailcontent = logged
        else:
            respond = session.get('https://bbs.pku.edu.cn/v2/thread.php?bid=71').content
            soup = BeautifulSoup(respond, 'lxml')
            items = soup.find_all(class_ = 'list-item-topic list-item')
            
            pids = [maxpid]
            for item in items:
                title = item.find(class_ = 'title l limit').text
                pid = item.find(class_ = 'id l').text
                if pid.isnumeric():
                    pid = int(pid)
                    if (pid > maxpid) and (len([word for word in positive if word in title]) > 0) and (len([word for word in negative if word in title]) == 0):
                        link = 'https://bbs.pku.edu.cn/v2/' + item.find(class_ = 'link')['href']
                        mailcontent = mailcontent + '<a href = "' + link + '">' + title + '</a><br/><br/>'
                        pids.append(pid)
            maxpid = max(pids)
        
        if len(mailcontent) > 0:        
            msg = MIMEText('<html>' + mailcontent + '</html>', 'html', 'utf-8')  
            msg['Subject'] = subject
            smtp = smtplib.SMTP()  
            smtp.connect(smtpserver)  
            smtp.login(username, password)  
            smtp.sendmail(sender, receiver, msg.as_string())  
            smtp.quit()

        session.close()
        print(datetime.now())
        time.sleep(seconds)
except:
    mailcontent = traceback.format_exc()
    print(mailcontent)

    msg = MIMEText(mailcontent)  
    msg['Subject'] = subject
    smtp = smtplib.SMTP()  
    smtp.connect(smtpserver)  
    smtp.login(username, password)  
    smtp.sendmail(sender, receiver, msg.as_string())  
    smtp.quit()

