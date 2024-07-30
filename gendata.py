"""
This app uses Python 3.12, numpy, and pandas to generate a set of data points and plot them on a graph.
"""

# Import the necessary libraries (may need to PIP install numpy and pandas)
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

"""
Create a function 'gendata' that generates a set of data points (x, f(x)) and returns them as a pandas data frame.
Arguments:
- 'x_range' is a tuple of two integers representing the range of x values to generate.
Returns:
- A pandas data frame with two columns, 'x' and 'y'.
Details:
- 'x' values are generated randomly between x_range[0] and x_range[1].
- 'y' values are generated as a non-linear function of x with excessive random noise: y = x ^ 1.5  + noise.
- The data frame is sorted by the 'x' values.
"""