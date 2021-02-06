import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from scipy.stats import gaussian_kde
raw = pd.read_csv('simdata.csv',index_col=False,header =0)

limits = [0,6]

rawdata =raw.iloc[:,0]
drdata =raw.iloc[:,1]
saverdata =raw.iloc[:,2]
scimputedata =raw.iloc[:,3]
magicdata =raw.iloc[:,4]
cmfdata =raw.iloc[:,5]
mydata =raw.iloc[:,6]
fig, ax = plt.subplots()

plt.scatter(rawdata.values.flatten(),drdata.values.flatten(),s=1,alpha=0.5)
plt.plot(limits,limits,'r-.',linewidth=2)
plt.xlim(limits)
plt.ylim(limits)
plt.title('DrImpute',fontsize=20)
plt.text(0.2, 0.9, 'SSE=306.9\n'+'PCC=0.675',
        horizontalalignment='center',
        verticalalignment='center',
        fontsize=20, color='black',
        transform=ax.transAxes)
plt.show()
#fig2 =plt.figure('fig2')
#fig1, ax1 = plt.subplots()
plt.scatter(rawdata.values.flatten(),scimputedata.values.flatten(),s=1,alpha=0.5)
plt.plot(limits,limits,'r-.',linewidth=2)
plt.xlim(limits)
plt.ylim(limits)
plt.title('scImpute',fontsize=20)
plt.text(0.2, 0.9, 'SSE=287.7\n'+'PCC=0.706',
        horizontalalignment='center',
        verticalalignment='center',
        fontsize=20, color='black',
        transform=ax.transAxes)
plt.show()
plt.scatter(rawdata.values.flatten(),mydata.values.flatten(),s=1,alpha=0.5)
plt.plot(limits,limits,'r-.',linewidth=2)
plt.xlim(limits)
plt.ylim(limits)
plt.title('scLRTC',fontsize=20)
plt.text(0.2, 0.9, 'SSE=268.8\n'+'PCC=0.707',
        horizontalalignment='center',
        verticalalignment='center',
        fontsize=20, color='black',
        transform=ax.transAxes)
plt.show()
plt.scatter(rawdata.values.flatten(),saverdata.values.flatten(),s=1,alpha=0.5)
plt.plot(limits,limits,'r-.',linewidth=2)
plt.xlim(limits)
plt.ylim(limits)
plt.title('SAVER',fontsize=20)
plt.text(0.2, 0.9, 'SSE=657.8\n'+'PCC=0.068',
        horizontalalignment='center',
        verticalalignment='center',
        fontsize=20, color='black',
        transform=ax.transAxes)
plt.show()
plt.scatter(rawdata.values.flatten(),magicdata.values.flatten(),s=1,alpha=0.5)
plt.plot(limits,limits,'r-.',linewidth=2)
plt.xlim(limits)
plt.ylim(limits)
plt.title('MAGIC',fontsize=20)
plt.text(0.2, 0.9, 'SSE=380.1\n'+'PCC=0.462',
        horizontalalignment='center',
        verticalalignment='center',
        fontsize=20, color='black',
        transform=ax.transAxes)
plt.show()
plt.title('CMF-Impute',fontsize=20)
plt.scatter(rawdata.values.flatten(),cmfdata.values.flatten(),s=1,alpha=0.5)
plt.plot(limits,limits,'r-.',linewidth=2)
plt.xlim(limits)
plt.ylim(limits)
plt.text(0.2, 0.9, 'SSE=338.7\n'+'PCC=0.669',
        horizontalalignment='center',
        verticalalignment='center',
        fontsize=20, color='black',
        transform=ax.transAxes)
plt.show()