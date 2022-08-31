# MRI-Augmentation
A 2D/3D Augmentation Tool for MRI Images
<br />

# Description
The MRI-Augmentation tool can be applied to MRI images to create plausible noisy or deformed scans during the deep learning algorithm training. This toolbox, developed in MATLAB R2021, is an implementation of the algorithm proposed in [1].
<br />

# Algorithm

**Elastic deformation:** deforms images using random displacement fields.
<br />
**Intensity inhomogeneity:** generates random intensity inhomogeneity in images.
<br />
**Gibbs ringing:** generates random Gibbs ringing (oscillation) artefact in images.
<br />
**Motion ghosting:** generates random motion ghosting artefact in images.
<br />
**Additive noise:** introduces random zero-mean Gaussian noise to images.
<br />
**Multiplicative noise:** introduces random zero-mean speckle noise to images.
<br />
**Rotation:** randomly rotates images about the axes.
<br />
**Mirroring:** randomly flips images about the axes.
<br />
**Blurring:** generates blurring artefact in images.
<br />

# Citation
When you publish your research using this toolbox, please cite [1] as
<br />
<br />
@Article{Ghazi2022,
<br />
  title = {{FAST-AID Brain}: Fast and Accurate Segmentation Tool using Artificial Intelligence Developed for Brain},
  <br />
  author = {Mehdipour Ghazi, Mostafa and Nielsen, Mads},
  <br />
  journal = {arXiv preprint},
  <br />
  volume = {},
  <br />
  pages = {},
  <br />
  year = {2022},
  <br />
  doi = {10.48550/ARXIV.2208.14360},
  <br />
  publisher = {arXiv},}
<br />

# References
[1] Mehdipour Ghazi, M., Nielsen, M., 2022. FAST-AID Brain: Fast and Accurate Segmentation Tool using Artificial Intelligence Developed for Brain. arXiv preprint arXiv:2208.14360.
<br />

Contact: mostafa.mehdipour@gmail.com
<br />
