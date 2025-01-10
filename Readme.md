# Region-Adaptive Method for Precise Optical System Alignment Based on Deep Learning

## Authors

- **Qiran Shi 1** – Primary developer and author of the code.

- **Jun Zhu* 1,2** – Contributor to the idea formulation and manuscript writing.

     1.State Key Laboratory of Precision Measurement Technology and Instruments, Department of Precision Instrument, Tsinghua University, Beijing 100084, China

  2. Tsinghua-Foxconn Nanotechnology Research Center, Tsinghua University, Beijing 100084, China

  [*j_zhu@tsinghua.edu.cn](mailto:*j_zhu@tsinghua.edu.cn)

## Introduction

This repository contains the core code for the method described in the paper titled **"Region-adaptive method for precise optical system alignment based on deep learning"**. The method focuses on precise alignment of optical systems using deep learning. This approach aims to enhance the accuracy of optical alignment, particularly in high-precision optical systems.

The repository includes three main parts:

1. **Dataset Generation for GI Method**
2. **Dataset Generation for SI  Method**
3. **Evaluation of the image quality after Alignment**

## Usage

### Prerequisites

- CodeV (Optical Design Software): Version 11.0 is required for the optical design simulations and analyses. Ensure that you have a valid license and the software is properly installed on your system.

### Dataset Generation for GI Method

- To generate the dataset for the GI method, run: `dataset_generation_GI.m`. 
- The arrays `train_data.mat` and `train_label.mat` will be generated after running this script. 
- An example dataset, `GI_dataset_example.mat`, is provided in the `data` folder for reference. 
- After generating the dataset, you can use TensorFlow or PyTorch to build a DNN for training the data. The `data` folder includes the training results for `GI_dataset_example.mat`, stored as `network_predicted_misalignments_for_GI.mat`.

### Dataset Generation for SI Method

- To generate the dataset for the SI method, run: `dataset_generation_SI.m`. 
- When running this script, the misalignment values of the GI-aligned systems will be calculated based on `GI_dataset_example.mat` and `network_predicted_misalignments_for_GI.mat`. You can also replace these with local data as needed.
- The arrays `train_data.mat` and `train_label.mat` will be generated after running this script. 
- An example dataset, `SI_dataset_example.mat`, is provided in the `data` folder for reference. 
- After generating the dataset, you can use TensorFlow or PyTorch to build a DNN for training the data. The `data` folder includes the training results for `SI_dataset_example.mat`, stored as `network_predicted_misalignments_for_SI.mat`.

### Data for SM fine-tuning

-  The misalignment values of the GI-SI-aligned systems can be calculated based on `SI_dataset_example.mat` and `network_predicted_misalignments_for_SI.mat`. You can also calculate the results with local data using the method provided in the above code.
- The sensitivity matrix approximation of the GI-SI-aligned systems can be calculated using the method provided in line 31 of `dataset_generation_SI.m`.

### Evaluation of these methods

- To evaluate wavefront aberrations after system alignment, run: `network_evaluation_wfe`.
- The alignment results for the GI, GI-SI, and GI-SI-SM methods can all be evaluated using this code. You can select the desired method for evaluation by modifying lines 12-26 in the script.
- Other parameters of the aligned systems can also be evaluated using similar methods.

## Code Structure

- `dataset_generation_GI.m`: Script to generate the GI method dataset.
- `dataset_generation_SI.m`: Script to generate the SI method dataset.
- `network_evaluation_wfe.m`: Script for evaluating the wavefront aberration of the aligned systems.
- `lens/`: Contains the example RC model for the data generation.
- `data/`: Example data.
- `cv_matlab_com_pack/`: A set of scripts for facilitating data transfer between CodeV and MATLAB.
- Other files in the repository serve as auxiliary functions or supporting files for running the three main scripts.

## Contributing

Contributions are welcome! If you have any improvements, fixes, or suggestions, feel free to fork the repository and submit a pull request.

1. Fork the repository
2. Create a new branch for your feature/fix
3. Commit your changes
4. Push to your fork and create a pull request

## License

This project is licensed under the **Academic Research License**. You are free to use, modify, and distribute this code for academic purposes only.   

## Acknowledgements

- This work is funded by the National Natural Science Foundation of China (NSFC) (62175123). 

## Disclaimer

This repository is for research purposes only. The authors do not provide support for deployment in production environments and disclaim any liability for its usage outside of its intended context.
