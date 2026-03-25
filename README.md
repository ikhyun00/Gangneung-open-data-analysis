# Gangneung-open-data-analysis

# 🚗 강릉시 주차 문제 해결을 위한 데이터 분석 프로젝트

<div align="center">
  <img src="https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white">
  <img src="https://img.shields.io/badge/ggplot2-FF6384?style=for-the-badge">
  <img src="https://img.shields.io/badge/randomForest-228B22?style=for-the-badge">
  <img src="https://img.shields.io/badge/clustering-KMeans%20%7C%20KMedoids-blue?style=for-the-badge">
</div>

---

## 📖 프로젝트 개요

강릉시는 관광객 증가 및 차량 증가로 인해 **주차 공간 부족 문제가 지속적으로 발생**하고 있습니다.  
본 프로젝트는 공공데이터를 기반으로 **주차 수요를 분석하고 최적의 주차장 입지를 도출**하는 것을 목표로 합니다.

---

## 🎯 분석 목표

- 강릉시 주차 수요 및 공급 구조 분석
- 주차 부족 지역 도출
- 데이터 기반 최적 주차 입지 선정
- 정책 활용 가능한 인사이트 제공

---

## 📊 데이터 구성

공공데이터를 활용하여 주요 변수를 구축했습니다.

| 변수 | 설명 |
|------|------|
| 주차장면적 | 지역별 주차 공간 규모 |
| 등록차량수 | 차량 수 |
| 관광객수 | 유동 인구 |
| 인구수 | 상주 인구 |
| 사업체수 / 종사자수 | 경제 활동 |
| 금융시설 / 문화시설 | 인프라 |
| 수요량 | 차량 수요 |
| 주차부족지수 | 주차 공급 대비 부족 수준 |

---

## ⚙️ 데이터 전처리

- 문자열 숫자 데이터 정제 (쉼표 제거 후 numeric 변환)
- 변수 표준화 (Z-score)
- 결측치 처리
- 파생 변수 생성

📌 주요 파생 변수
- 주차 수요지수
- 경제지수
- 인프라지수
- 수용지수

---

## 📈 분석 방법

### 1. 변수 중요도 분석
- Random Forest 기반 변수 중요도 도출  
- 주요 영향 변수 선정

### 2. 지수 생성
각 변수 중요도를 기반으로 가중치 적용

- 주차수요지수 = 관광객수 + 등록차량수 + 인구수
- 경제지수 = 종사자수 + 사업체수
- 인프라지수 = 금융시설 + 문화시설
- 수용지수 = 주차장수용대수 + 수용률

---

### 3. 군집 분석

- K-means Clustering
- K-medoids Clustering

👉 지역별 특성에 따른 군집 분류 수행

---

### 4. 머신러닝 모델

- Random Forest 활용
- 주차부족지수 예측 및 변수 중요도 분석

---

### 5. 최적 입지 선정

다중 지표를 결합한 최종 평가식:

Z = 0.35 × 수요량  
  + 0.30 × 주차수요지수  
  + 0.19 × 수용지수  
  + 0.14 × 경제지수  
  + 0.02 × 인프라지수  

---

## 📌 주요 분석 결과

- 주차 문제는 **관광지 및 상업지역 중심으로 집중**
- 주차 수요와 부족 지수가 높은 지역 확인
- 최적 입지 후보:

👉 교1동, 성덕동, 홍제동, 내곡동 등

---

## 💡 기대 효과

- 주차난 해소 및 교통 혼잡 감소
- 관광객 편의성 향상
- 지역 경제 활성화 기여
- 데이터 기반 도시 정책 수립 가능

---

## 📁 프로젝트 구조

```bash
├── data/
├── preprocessing/
│   └── data_preprocessing.R
├── analysis/
│   └── clustering_and_modeling.R
├── report/
│   └── 강릉시_주차분석_보고서.pdf
└── README.md
