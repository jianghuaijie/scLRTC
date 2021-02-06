'''
@Author     :   Xu Junlin
@Software   :   PyCharm 2019.3 (Professional Edition)
'''
import numpy as np
import matplotlib
import matplotlib.pyplot as plt

import matplotlib.ticker as ticker

def heatmap(data, row_labels, col_labels, ax=None,
            cbar_kw={}, cbarlabel="", **kwargs):
    """
    Create a heatmap from a numpy array and two lists of labels.

    Parameters
    ----------
    data
        A 2D numpy array of shape (N, M).
    row_labels
        A list or array of length N with the labels for the rows.
    col_labels
        A list or array of length M with the labels for the columns.
    ax
        A `matplotlib.axes.Axes` instance to which the heatmap is plotted.  If
        not provided, use current axes or create a new one.  Optional.
    cbar_kw
        A dictionary with arguments to `matplotlib.Figure.colorbar`.  Optional.
    cbarlabel
        The label for the colorbar.  Optional.
    **kwargs
        All other arguments are forwarded to `imshow`.
    """

    if not ax:
        ax = plt.gca()

    # Plot the heatmap
    im = ax.imshow(data, **kwargs,vmin=0, vmax=1)

    # Create colorbar
    cbar = ax.figure.colorbar(im, ax=ax, **cbar_kw)
    tick_locator = ticker.MaxNLocator(nbins=11)

    cbar.locator = tick_locator
    #cbar.set_ticks([0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1])
    cbar.update_ticks()
    cbar.ax.set_ylabel(cbarlabel, rotation=-90, va="bottom")

    # We want to show all ticks...
    ax.set_xticks(np.arange(data.shape[1]))
    ax.set_yticks(np.arange(data.shape[0]))
    # ... and label them with the respective list entries.
    font1 = {'family': 'Times New Roman',
             'weight': 'normal',
             'size': 16}
    font2 = {'family': 'Times New Roman',
             'weight': 'normal',
             'size': 16}
    ax.set_xticklabels(col_labels,font1)
    ax.set_yticklabels(row_labels,font2)

    # modify this part and change the label direction
    # Let the horizontal axes labeling appear on top.
    ax.tick_params(top=False, bottom=True,
                   labeltop=False, labelbottom=True)

    # Rotate the tick labels and set their alignment.
    plt.setp(ax.get_xticklabels(), rotation=0, ha="center",
             rotation_mode="anchor")

    # Turn spines off and create white grid.
    for edge, spine in ax.spines.items():
        spine.set_visible(False)

    ax.set_xticks(np.arange(data.shape[1]+1)-.5, minor=True)
    ax.set_yticks(np.arange(data.shape[0]+1)-.5, minor=True)
    ax.grid(which="minor", color="w", linestyle='-', linewidth=0.5)
    ax.tick_params(which="minor", bottom=False, left=False)

    return im, cbar

def annotate_heatmap(im, data=None, valfmt="{x:.2f}",
                     textcolors=["black", "white"],
                     threshold=None, **textkw):
    """
    A function to annotate a heatmap.

    Parameters
    ----------
    im
        The AxesImage to be labeled.
    data
        Data used to annotate.  If None, the image's data is used.  Optional.
    valfmt
        The format of the annotations inside the heatmap.  This should either
        use the string format method, e.g. "$ {x:.2f}", or be a
        `matplotlib.ticker.Formatter`.  Optional.
    textcolors
        A list or array of two color specifications.  The first is used for
        values below a threshold, the second for those above.  Optional.
    threshold
        Value in data units according to which the colors from textcolors are
        applied.  If None (the default) uses the middle of the colormap as
        separation.  Optional.
    **kwargs
        All other arguments are forwarded to each call to `text` used to create
        the text labels.
    """

    if not isinstance(data, (list, np.ndarray)):
        data = im.get_array()

    # Normalize the threshold to the images color range.
    if threshold is not None:
        threshold = im.norm(threshold)
    else:
        threshold = im.norm(data.max())/2.

    # Set default alignment to center, but allow it to be
    # overwritten by textkw.
    kw = dict(horizontalalignment="center",
              verticalalignment="center")
    kw.update(textkw)

    # Get the formatter in case a string is supplied
    if isinstance(valfmt, str):
        valfmt = matplotlib.ticker.StrMethodFormatter(valfmt)

    # Loop over the data and create a `Text` for each "pixel".
    # Change the text's color depending on the data.
    texts = []
    for i in range(data.shape[0]):
        for j in range(data.shape[1]):
            kw.update(color=textcolors[int(im.norm(data[i, j]) > threshold)])
            text = im.axes.text(j, i, valfmt(data[i, j], None), **kw)
            texts.append(text)

    return texts

# input data ARI
datasets = ["Usoskin", "Pollen","Yan", "Zeisel","Mouse","PBMC"]
methods = ["Raw","DrImpute", "SAVER", "scImpute","MAGIC","CMF-Impute","scLRTC"]
results = np.array([[0.891,0.900,0.930,0.212,0.115,0.932,0.940],
                    [0.934,0.952,0.937,0.951,0.781,0.952,0.962],
                    [0.641,0.670,0.655,0.618,0.565,0.641,0.722],
                    [0.788,0.764,0.785,0.403,0.221,0.797,0.850],
                    [0.583,0.568,0.560,0.423,0.319,0.559,0.630],
                    [0.679,0.654,0.667,0.384,0.233,0.823,0.831]])
# #input data NMI
# datasets = ["Usoskin", "Pollen","Yan", "Zeisel"]
# methods = ["Raw","DrImpute", "SAVER", "scImpute","MAGIC","CMF-Impute","scLRTC"]
# results = np.array([[0.887,0.780,0.829,0.510,0.228,0.915,0.915],
#                     [0.949,0.952,0.967,0.924,0.881,0.956,0.971],
#                     [0.797,0.803,0.800,0.792,0.749,0.797,0.845],
#                     [0.743,0.698,0.744,0.572,0.363,0.734,0.764],
#                     [0.756,0.736,0.732,0.696,0.547,0.745,0.765],
#                     [0.744,0.735,0.743,0.589,0.407,0.792,0.808]])
fig, ax = plt.subplots(figsize=(11,7))
im, cbar = heatmap(results, datasets, methods, ax=ax,
                   cmap=plt.get_cmap("GnBu"))

texts = annotate_heatmap(im, valfmt="{x:.3f}",size = 16)
fig.tight_layout()
# sive ARI.pdf or NMI.pdf
plt.savefig('D:/study/bioinformatics/CMFImpute-master2/analysis_mainARI6.png', dpi=600)
plt.show()