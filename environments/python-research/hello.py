# %% Cell 1
def main():
    print("Hello from python-research!")

if __name__ == "__main__":
    main()

# %% Cell 2
import uproot
import numpy as np
import hist
import matplotlib.pyplot as plt
import mplhep as hep
from particle import Particle
import awkward as ak

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
