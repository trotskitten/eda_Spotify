# 🎧 Spotify EDA - Multidimensional Exploration of Music Genres and Popularity 📊✨

This project is an exploratory data analysis (EDA) of Spotify tracks aimed at understanding how audio features, genre structures, and popularity interact. It focuses on uncovering patterns, relationships, and latent structures within the dataset.

The analysis combines **statistical exploration**, **visualization**, and **distance-based methods** to examine how genres relate to each other and how popularity behaves across different musical genres.

---

## Context & Intent

This project was developed as part of a data science learning journey, with the goal of exploring how musical characteristics and popularity interact within a large-scale dataset.

Rather than focusing on prediction, the project emphasizes:
- interpretability  
- structural understanding of genres  
- critical analysis of metrics such as popularity  

The work reflects an exploratory approach, where insights emerge through iterative analysis and visualization.

---

## 📑 Table of Contents

1. [Project Overview](#-project-overview)
2. [Key Features](#-key-features)
3. [How It Works](#-how-it-works)
4. [Project Structure](#-project-structure)
5. [Requirements](#-requirements)

---

## 📖 Project Overview

The analysis revolves around three main components:

### 1. 📊 Descriptive and Distributional Analysis
- Exploration of feature distributions (e.g., popularity, energy, danceability)
- Identification of skewness, multimodality, and outliers
- Comparison of central tendency (mean vs. median)

### 2. 🔗 Correlation and Feature Relationships
- Analysis of relationships between audio features
- Identification of weak correlations with popularity
- Detection of multicollinearity between variables (e.g., energy and loudness)

### 3. 📐 Distance-Based Genre Comparison
- Construction of a multidimensional feature space
- Computation of distances between genres
- Identification of:
  - most similar genre pairs  
  - most dissimilar genre pairs  

---

## ✨ Key Features

### 🎯 Popularity Analysis  
- Reveals a **multimodal distribution**, suggesting different popularity tiers  
- Highlights strong skew toward low-popularity tracks  
- Explores the trade-off between **mean and median**  

### 🔍 Feature Relationship Analysis  
- Shows weak direct correlations between audio features and popularity  
- Identifies strong relationships between features (e.g., energy ↔ loudness)  
- Highlights redundancy and potential dimensional overlap  

### 🧩 Genre Structure Exploration  
- Uses **multidimensional distance** to compare genres  
- Identifies **boundary genres** (e.g., sleep) and **close genres**  
- Provides a foundation for clustering and segmentation  

### 📊 Multivariate Visualization  
- Uses 2D and 3D plots to explore feature interactions  
- Compares genres in feature space (e.g., sleep vs. death-metal)  
- Highlights separation between stylistic profiles  

---

## 🤔 How It Works

### **Analytical Pipeline**

1. **📥 Data Preparation**
   - Load dataset and clean missing or inconsistent values  
   - Select relevant features for analysis  

2. **📊 Exploratory Analysis**
   - Analyze distributions (e.g., popularity)  
   - Compare central tendencies across genres  

3. **🔗 Correlation Analysis**
   - Compute correlation matrices  
   - Identify weak and strong relationships  

4. **📐 Feature Space Construction**
   - Aggregate features at genre level  
   - Normalize variables to ensure comparability  

5. **📏 Distance Computation**
   - Compute Euclidean distances between genres  
   - Build a distance matrix  

6. **📊 Interpretation**
   - Extract most similar and dissimilar pairs  
   - Identify genre clusters and structural patterns  

---

## 📂 Project Structure

### **Key Files & Directories**

- `Spotify_eda.ipynb` → Main notebook containing the full analysis  
-  dataset retrieved through Kaggle APIs with the library `kagglehub`

---

## ⚙️ Requirements

### **Dependencies**
- Python libraries:
  - `pandas`
  - `numpy`
  - `matplotlib`
  - `seaborn`
  - `plotly`

### **Install Dependencies**
```bash
pip install pandas numpy matplotlib seaborn plotly
