# Contents
1. [Introduction](Introduction)
2. [Requirements](Requirements)
3. [How to run](How-to-run)
4. [Citation](Citation)
5. [License](License)

# Introduction

In this web page, we provide the MATLAB implementation of the gender classification method proposed in our paper '
[Joint Swing Energy for Skeleton-Based Gender Classification](https://doi.org/10.1109/ACCESS.2021.3058745).' In this study, we proposed a new gait feature called joint swing energy (JSE) for gender classification. To demonstrate the effectiveness of JSE for gender classification, we trained four machine learning algorithms: k-nearest neighbors (KNN), Naive Bayes (NB), Support Vector Machine (SVM), and decision tree (DT) models using JSE. Additionally, we evaluated the models on four publicly available gait datasets.

# Requirements

The proposed method was implemented using MATLAB R2018a. For the implementation of the four machine learning algorithms (KNN, NB, SVM, and DT), we utilized the MATLAB functions 'fitcknn,' 'fitcnb,' 'fitcsvm,' and 'fitctree,' respectively. To accomplish this, the 'Statistics and Machine Learning Toolbox' was employed. Therefore, to run our code, you will need to install MATLAB on your computer, along with the 'Statistics and Machine Learning Toolbox.'

# How to run

## 1. Dataset Preparation

In this study, we utilized four publicly available gait datasets as described below:
* Dataset A: This dataset is the Kinect Gait Biometry Dataset, which consists of data from 164 individuals walking in front of an Xbox 360 Kinect Sensor. If you wish to download this dataset, please click [here](https://www.researchgate.net/publication/275023745_Kinect_Gait_Biometry_Dataset_-_data_from_164_individuals_walking_in_front_of_a_X-Box_360_Kinect_Sensor) to access the download link. To obtain gender information, you will also need to download the Gender and Body Mass Index (BMI) Data for the Kinect Gait Biometry Dataset. Please click [here](https://www.researchgate.net/publication/308929259_Gender_and_Body_Mass_Index_BMI_Data_for_Kinect_Gait_Biometry_Dataset_-_data_from_164_individuals_walking_in_front_of_a_X-Box_360_Kinect_Sensor) to access the download link for the gender data.

* Dataset B: This dataset contains kinematic gait data recorded using a Microsoft Kinect v2 sensor during gait sequences over a treadmill. If you are interested in downloading this dataset, please click [here](https://ieee-dataport.org/open-access/kinematic-gait-data-using-microsoft-kinect-v2-sensor-during-gait-sequences-over) to find the download link.

* Dataset C: This dataset is the UPCV gait dataset. To obtain this dataset, kindly contact Mr. Dimitris Kastaniotis.

* Dataset D: This dataset is the UPCV gait K2 dataset. If you are interested in obtaining this dataset, please contact Mr. Dimitris Kastaniotis.

## 2. Data Transformation (from .txt to .csv) for Dataset A Only

The skeleton sequences in Dataset A are stored as text files with the filename extension .txt. To facilitate data handling, we converted the data format of each sequence from .txt to .csv. Please run the script named 'step1_data_transformation_from_txt_to_csv.m.' After running the .m file, you will obtain the CSV version of each sequence.

## 3. Joint Swing Energy (JSE) Feature Extraction

Please execute the script named 'step2_JSE_feature_extraction.m.' After running the .m file, you will obtain the JSE feature vectors.

## 4. Leave-one-participant-out (LOPO) Cross-Validation

To assess the performance of the proposed gender classification method, we utilized leave-one-participant-out (LOPO) cross-validation. Please execute the script named 'step3_LOPO_CV_dataset_generation.m.' After running the .m file, you will obtain the training and testing datasets used in each cross-validation fold.

## 5. Hyperparameter Optimization

To determine the optimal hyperparameter configuration for each model, we conducted hyperparameter optimization. Please execute the following .m files:
* 'step4_hyperparameter_optimization_knn.m'
* 'step4_hyperparameter_optimization_nb.m'
* 'step4_hyperparameter_optimization_svm.m'
* 'step4_hyperparameter_optimization_tree.m'

For instance, by running the first .m file mentioned above, you will obtain the trained KNN model.

NOTE: Hyperparameter optimization is a time-consuming process. If you wish to skip it, you can download and use our pre-trained models from [here](https://drive.google.com/file/d/11X_iL6hvS8fUtrrFFedLEoiMSE_8gAWK/view?usp=sharing). In the 'trained_model' folder, we have provided the pre-trained models.

## 6. Performance Evaluation

Please execute the following .m files:
* 'step5_evaluation_knn.m'
* 'step5_evaluation_nb.m'
* 'step5_evaluation_svm.m'
* 'step5_evaluation_tree.m'

For example, running the first .m file mentioned above will display the evaluation results of the KNN model in the command window of MATLAB.

# Citation

Please cite this paper in your publications if it helps your research.

```
@article{kwon2021joint,
  author={Kwon, Beom and Lee, Sanghoon},
  journal={IEEE Access},
  title={Joint Swing Energy for Skeleton-Based Gender Classification},  
  year={2021},
  volume={9},
  pages={28334-28348},  
  doi={10.1109/ACCESS.2021.3058745}
}
```
Paper link:
* [Joint Swing Energy for Skeleton-Based Gender Classification](https://doi.org/10.1109/ACCESS.2021.3058745)

# License

Our codes are freely available for non-commercial use.
