# %% Cell 1
def main():
    print("Hello from python-research!")

if __name__ == "__main__":
    main()

# %% Cell 2
from ctypes import LibraryLoader
import uproot
import numpy as np
import hist
import matplotlib.pyplot as plt
import mplhep as hep
from particle import Particle
import awkward as ak
import pandas as pd

# %% Cell 3
a = np.random.normal(0, 1, 1000)
h = hist.Hist.new.Reg(100, -5, 5).Int64().fill(a)
hep.style.use(hep.style.LHCb2)
hep.histplot(h)

# %% Cell 4
piplus = Particle.from_pdgid(211)
print(piplus.mass)
print(piplus.name)
print(piplus.charge)

# %% Cell 5
def plot(df):
    h, bins = np.histogram(df, bins=100, range=(0, 100))
    hep.histplot(h, bins, yerr=True)
    plt.xlabel("x")

def plot2d(df,df2):
    h,bins = np.histogram2d(df,df2,bins=(100,100),range=((0,100),(0,100)))
    hep.histplot2d(h, bins, yerr=True)
    plt.xlabel("x")
    plt.ylabel("y")

# %% Cell 6
with uproot.open("~/root-files/302506.root") as my_file:
    tree = my_file["UTDataMonTr/n"]
    odinBunchID = tree['odinBunchID'].arrays(library="np")
    nDigits = tree['nUTDigits'].arrays(library="np")

# %% Cell 7
axis_reg = hist.axes.Regular(100,0,100,name="name")
axis_reg2 = hist.axes.Regular(100,0,100,name="name2")
print(len(odinBunchID['odinBunchID']))
print(len(nDigits['nUTDigits']))

h = hist.Hist(axis_reg,axis_reg2).fill(odinBunchID['odinBunchID'],nDigits['nUTDigits'])
hep.hist2dplot(h)

# %% Cell 8
hep.hist2dplot(odinBunchID['odinBunchID'],nDigits['nUTDigits'])
