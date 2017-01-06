# BoutonDetection

This is demonstration code that illustrates a new algorithm for the detection of axonal synaspses in 3D microscopy images.
This code contains a simple gui that allows the analysis of several images, and a simple user interface to correct any mistakes made by the algorithm. See Instructions pdf file for more detail on how to use.

We ask to submit negative examples, with corresponding images, so that we may improve the performance of the algorithm...

The analysis of axonal synapses (boutons) is often required when studying structural plasticity in the brain. To date, this type analysis has been largely manual or semi-automated, and relies on a step that traces the axon before detecting boutons, which if fails, limits the ability to detect axonal boutons. We propose a new algorithm that does not require tracing the axon to detect axonal boutons in 3D two-photon images taken from the mouse cortex. 

## The final algorithm proposed has the following main steps: ##
1. A Laplacian of Gaussians (LoG) based feature enhancement module to accentuate the appearance of boutons. 

2.  A Speeded Up Robust Features (SURF) interest point detector to find candidate locations for feature extraction. 

3.  Non-maximum suppression to eliminate candidates that were detected more than once in the same local region. 

4.  Generation of feature descriptors based on Gabor filters. 

5.  A Support Vector Machine (SVM) classifier, trained on features from labelled data, was lastly used to separate the features into bouton and non-bouton instances. 

