# Contents
1. [Introduction](Introduction)
2. [Requirements](Requirements)
3. [How to run](How-to-run)
4. [Citation](Citation)
5. [License](License)

# Introduction

In this web-page, we provide the MATLAB implementation of the gender classification method proposed in our paper "[Joint Swing Energy for Skeleton-Based Gender Classification](https://doi.org/10.1109/ACCESS.2021.3058745)." In this study, we proposed a new gait feature, called joint swing energy (JSE), for gender classification. To demonstrate the effectiveness of JSE for gender classification, we trained four machine learning algorithms, including k-nearest neighbors (KNN), Naive Bayes (NB), Support Vector Machine (SVM), and decision tree (DT) models, using JSE. In addition, we evaluated the models on four publicly available gait datasets.

# Requirements

The proposed method was implemented using MATLAB R2018a. To implement the four machine learning algorithms (i.e., KNN, NB, SVM, and DT), we used the MATLAB functions "fitcknn," "fitcnb," "fitcsvm," and "fitctree," respectively. To this end, we used the "Statistics and Machine Learning Toolbox." Therefore, if you want to run our code, you need to install MATLAB on your PC. In addition, you also need to install the "Statistics and Machine Learning Toolbox."

# How to run

## 1. Dataset Preparation

In this study, we used four publicly available gait datasets as follows:
* Dataset A: This dataset is the Kinect Gait Biometry Dataset - data from 164 individuals walking in front of a X-Box 360 Kinect Sensor. If you want to download this dataset, please click [here](https://www.researchgate.net/publication/275023745_Kinect_Gait_Biometry_Dataset_-_data_from_164_individuals_walking_in_front_of_a_X-Box_360_Kinect_Sensor). You can then find the download link. To obtain gender information, you also need to download the Gender and Body Mass Index (BMI) Data for the Kinect Gait Biometry Dataset. If you want to download this gender data, please click [here](https://www.researchgate.net/publication/308929259_Gender_and_Body_Mass_Index_BMI_Data_for_Kinect_Gait_Biometry_Dataset_-_data_from_164_individuals_walking_in_front_of_a_X-Box_360_Kinect_Sensor). You can then find the download link.

* Dataset B: This dataset is the Kinematic gait data using a Microsoft Kinect v2 sensor during gait sequences over a treadmill. If you want to download this dataset, please click [here](https://ieee-dataport.org/open-access/kinematic-gait-data-using-microsoft-kinect-v2-sensor-during-gait-sequences-over). Then, you can find the download link.

* Dataset C: This dataset is the UPCV gait dataset. If you want to obtain this dataset, please contact Mr. Dimitris Kastaniotis.

* Dataset D: This dataset is the UPCV gait K2 dataset. If you want to obtain this dataset, please contact Mr. Dimitris Kastaniotis.

## 2. Data Transformation (from .txt to .csv) for Dataset A Only

The skeleton sequences in Dataset A are stored as text files (i.e., filename extension is .txt). For ease of data handling, we transformed the data format of each sequence from .txt to .csv. Run "step1_data_transformation_from_txt_to_csv.m." After the m file is executed, you can obtain the csv version of each sequence.

## 3. Joint Swing Energy (JSE) Feature Extraction

Run "step2_JSE_feature_extraction.m." After the m file is executed, you can obtain the JSE feature vectors.

## 4. Leave-one-participant-out (LOPO) Cross Validation

For assessing the performance of the proposed gender classification method, we used leave-one-participant-out (LOPO) cross validation. Run "step3_LOPO_CV_dataset_generation.m." After the m file is executed, you can obtain the training and testing datasets that are used in each cross validation fold.


## 5. Hyperparameter Optimization

To find the optimal hyperparameter configuration for each model, we performed hyperparameter optimization. Please run the following m files:
* "step4_hyperparameter_optimization_knn.m"
* "step4_hyperparameter_optimization_nb.m"
* "step4_hyperparameter_optimization_svm.m"
* "step4_hyperparameter_optimization_tree.m"

For example, if you execute the first m file above, you can obtain the trained KNN model.

NOTE) If you want to evaluate our trained models, you can skip the hyperparameter optimization. In the "trained_model" folder, we provide our trained models.

## 6. Performance Evaluation

Please run the following m files:

* "step5_evaluation_knn.m"
* "step5_evaluation_nb.m"
* "step5_evaluation_svm.m"
* "step5_evaluation_tree.m"

For example, if you execute the first m file above, the evaluation results of the KNN model are displayed in the command window of MATLAB.

# Citation

Please cite this paper in your publications if it helps your research.

```
@article{kwon2021joint,
  title={Joint swing energy for skeleton-based gender classification},
  author={Kwon, Beom and Lee, Sanghoon},
  journal={IEEE Access},
  volume={9},
  pages={28334--28348},
  year={2021},
  publisher={IEEE}
}
```
Paper link:
* [Joint Swing Energy for Skeleton-Based Gender Classification](https://doi.org/10.1109/ACCESS.2021.3058745)

# License

Our codes are freely available for free non-commercial use.
