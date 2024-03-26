# 2024_Ramos_Martinez_BGHI
Data for Ramos, Martínez, 2024

This repository contains the BGHI structures in complex with glucose dimers selected in the study, obtained at different concentrations of the cosolvent (125 mM, 250 mM, 500 and 1000 mM) and generated with packmol (https://m3g.github.io/packmol/).

The `system.gro` and `system.pdb` files have the initial atomic coordinates of the systems with all their components: the BGHI crystal structure, water, glucose and sodium ions. The files `traj_protein+2BGL.pdb` are trajectories containing only the BGHI enzyme and glucose dimers with $S~>~50~\mathrm{\mathring{A}}^{-1}$. The script `print_scores.tcl` can be used to print out the distances d1, d2 and d3, as well as the value of $S$.

