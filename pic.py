#by 王兴坤 SY1909134
import os
import numpy as np
import pandas as pd
import matplotlib as mpl
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker


filepath="C:\\Users\\sure\\Desktop\\复杂网络大作业\\COVID-19data"
countrylist=['Italy','Korea, South','United Kingdom','US','Spain','Germany','France']
country=countrylist[6]
files=os.listdir(filepath)
Confirmed=[]
Deaths=[]
Recovered=[]
Active=[]
History=[]
x_axix=[]
x_axixall=[]
for file in files:
    x_axixall.append(file[:-9])

for file in files:
    #print(type(file[:-9]))
    
    x_axix.append(file[:-9])
    df=pd.DataFrame(pd.read_csv(filepath+'\\'+file))
    #print(df.columns.values.tolist())
    if ('Country/Region' in df.columns.values.tolist()):
        countryname='Country/Region'
    else:
        countryname="Country_Region"
    df_new=df.loc[df[countryname]==country]
    Confirmed.append(sum(df_new['Confirmed']))
    Deaths.append(sum(df_new['Deaths']))
    Recovered.append(sum(df_new['Recovered']))
    #Active.append(sum(df_new['Active']))
    History.append(Confirmed[-1]-Deaths[-1]-Recovered[-1])
#print(df['Country_Region'])
#print(df['Country/Region'])
#print(len(df['Country/Region']))
#print(df[0:2]['Country/Region']=='Mainland China')
#df_new=df.loc[df["Country/Region"]=="Mainland China"]
#print(sum(df_new['Deaths']))

'''
#画趋势图
fig1, ax = plt.subplots()
ax.plot( x_axix,Confirmed, color='red', label='Confirmed')
ax.plot( Deaths,  color='black', label='Deaths')
ax.plot( Recovered, color='green', label='Recovered')
plt.legend() # 显示图例

xticks=list(range(0,len(x_axix),5))
xlabels=[x_axix[x] for x in xticks]
xticks.append(len(x_axix))
xlabels.append(x_axix[-1])
ax.set_xticks(xticks)
ax.set_xticklabels(xlabels, rotation=40)


plt.xlabel('Time')
plt.ylabel('people')
plt.title(country)
plt.show()
'''


#画预测图


i=0
while(Confirmed[0]==0):
    del History[0]
    del Confirmed[0]
    del x_axix[0]
    i+=1
Confirmed=np.array(Confirmed)
logI=np.log(Confirmed)
#print(logI)
#print(logI-logI[0])
x=np.array(range(len(Confirmed)))
f1 = np.polyfit(x, logI-logI[0], 2)
#f1 = np.polyfit(x, Confirmed-Confirmed[0], 2)
#print(f1)
result=[f1[0],f1[1]+1/14]
print(result)
p1 = np.poly1d(f1)
#print(p1)
#已经拟合完成
x=np.array(range(len(x_axixall)))
yvals = p1(x)
#print(yvals)
#yvals+=Confirmed[0]
yvals+=logI[0]
yvals=np.exp(yvals)

yvals=list(yvals)
while(i>0):
    i-=1
    del x_axixall[0]
    del yvals[0]

fig1, ax = plt.subplots()
#ax.plot( x_axix,Confirmed, color='red', label='Confirmed')
ax.plot( x_axixall,yvals,  color='blue', label='Fit')
ax.scatter(x_axix, Confirmed,color='red', label='Confirmed')

plt.legend() # 显示图例

xticks=list(range(0,len(x_axixall),5))
xlabels=[x_axixall[x] for x in xticks]
xticks.append(len(x_axixall))
xlabels.append(x_axixall[-1])
ax.set_xticks(xticks)
ax.set_xticklabels(xlabels, rotation=40)

plt.xlabel('Time')
plt.ylabel('people')
plt.title(country)
plt.show()