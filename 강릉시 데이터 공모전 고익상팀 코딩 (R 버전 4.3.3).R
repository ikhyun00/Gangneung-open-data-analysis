# 사용 라이브러리 
#library(randomForest), library(dplyr), library(ggplot2), library(cluster)
# R 버전
package_version(R.version)

# 데이터 로드
df <- read.csv("C:/Users/ASUS/OneDrive/바탕 화면/주차장5.csv",header = TRUE,fileEncoding = "EUC-KR")
# 데이터에서 ,제거 및 숫자형 데이터로 변형
df$주차장면적 <- as.numeric(gsub(",", "", df$주차장면적))
df$관광객수 <- as.numeric(gsub(",", "", df$관광객수))
df$인구수 <- as.numeric(gsub(",", "", df$인구수))
df$읍면동면적 <- as.numeric(gsub(",", "", df$읍면동면적))
df$등록차량수 <- as.numeric(gsub(",", "", df$등록차량수))
df$주차장수용대수 <- as.numeric(gsub(",", "", df$주차장수용대수))
df$수용률 <- as.numeric(gsub(",", "", df$수용률))
df$수요량 <- as.numeric(gsub(",", "", df$수요량))
df$사업체수 <- as.numeric(gsub(",", "", df$사업체수))
df$종사자수 <- as.numeric(gsub(",", "", df$종사자수))
df$금융시설 <- as.numeric(gsub(",", "", df$금융시설))
df$문화시설 <- as.numeric(gsub(",", "", df$문화시설))
df$주차부족지수 <- as.numeric(gsub(",", "", df$주차부족지수))

df_selected <- df[, c("주차장면적", "관광객수", "인구수", "읍면동면적", "등록차량수", 
                      "주차장수용대수", "수용률", "수요량", "사업체수", "종사자수", 
                      "금융시설", "문화시설", "주차부족지수")]

df_scaled <- as.data.frame(scale(df_selected))

# 행정읍면동 변수는 표준화하지 않고 다시 추가
df_scaled$행정읍면동 <- df$행정읍면동

# 표준화된 데이터 확인
df <- df_scaled
head(df)

install.packages("randomForest")
library(randomForest)


set.seed(123)  # 재현성을 위해 시드 설정
주차수요지수 <- randomForest(주차장면적 ~ 관광객수 + 등록차량수 + 인구수, data = df)
# 변수 중요도 확인
importance_주차수요지수 <- importance(주차수요지수)  # 중요도 값을 저장
print(importance_주차수요지수)  # 중요도 출력

# 변수 중요도 그래프
varImpPlot(주차수요지수)

set.seed(123)  # 재현성을 위해 시드 설정
경제지수 <- randomForest(주차장면적 ~ 사업체수 + 종사자수, data = df)

importance_경제지수 <- importance(경제지수)  # 중요도 값을 저장
print(importance_경제지수)  # 중요도 출력

# 변수 중요도 그래프
varImpPlot(경제지수)


set.seed(123)  # 재현성을 위해 시드 설정
인프라지수 <- randomForest(주차장면적 ~ 금융시설 + 문화시설, data = df)

importance_인프라지수 <- importance(인프라지수)  # 중요도 값을 저장
print(importance_인프라지수)  # 중요도 출력

# 변수 중요도 그래프
varImpPlot(인프라지수)

set.seed(123)  # 재현성을 위해 시드 설정
수용지수 <- randomForest(주차장면적 ~ 주차장수용대수 + 수용률, data = df)
주차수요지수

importance_수용지수 <- importance(수용지수)  # 중요도 값을 저장
print(importance_수용지수)  # 중요도 출력

# 변수 중요도 그래프
varImpPlot(수용지수)

# 새로운 지수 생성
df$주차수요지수 <-  df$관광객수 * 0.31 + df$등록차량수 * 0.44 + df$인구수*0.25
df$경제지수 <- df$종사자수 * 0.82 + df$사업체수 * 0.18
df$인프라지수 <- df$금융시설 * 0.53 + df$문화시설 * 0.47
df$수용지수 <- df$주차장수용대수 * 0.6 + df$수용률 * 0.4 

library(dplyr)
# 필요한 패키지 로드
library(ggplot2)



# 군집 분석할 변수만 포함하는 데이터 프레임
df_cluster <- df[, c("행정읍면동", "수요량","주차수요지수", "경제지수", "인프라지수", "수용지수", "주차부족지수")]

# 결측치 처리
df_cluster[is.na(df_cluster)] <- 0

# K-means 군집 분석
set.seed(123) # 재현 가능성을 위해 시드 설정
kmeans_result <- kmeans(df_cluster[, c("수요량","주차수요지수", "주차부족지수", "인프라지수", "수용지수")], centers = 3, nstart = 25)

# 군집 결과를 원본 데이터 프레임에 추가
df_cluster$kmeans_cluster <- as.factor(kmeans_result$cluster)

# 군집 결과 시각화
ggplot(df_cluster, aes(x = 주차수요지수, y = 주차부족지수, color = kmeans_cluster, label = 행정읍면동)) +
  geom_point(size = 3) +
  geom_text(vjust = 1.5, hjust = 1.2, size = 3) +
  labs(title = "K-means Clustering: 주차수요지수 vs 주차부족지수",
       x = "주차수요지수",
       y = "주차부족지수") +
  theme_minimal() +
  scale_color_discrete(name = "군집")

ggplot(df_cluster, aes(x = 수요량, y = 주차부족지수, color = kmeans_cluster, label = 행정읍면동)) +
  geom_point(size = 3) +
  geom_text(vjust = 1.5, hjust = 1.2, size = 3) +
  labs(title = "K-means Clustering: 수요량 vs 주차부족지수",
       x = "수요량",
       y = "주차부족지수") +
  theme_minimal() +
  scale_color_discrete(name = "군집")
# 필요한 패키지 로드
library(cluster)  # K-medoids를 위한 패키지
# K-medoids 군집 분석
set.seed(123) # 재현 가능성을 위해 시드 설정
kmedoids_result <- pam(df_cluster[, c("수요량", "주차수요지수", "주차부족지수", "인프라지수", "수용지수")], k = 3)

# 군집 결과를 원본 데이터 프레임에 추가
df_cluster$kmedoids_cluster <- as.factor(kmedoids_result$clustering)

# 군집 결과 시각화
ggplot(df_cluster, aes(x = 주차수요지수, y = 주차부족지수, color = kmedoids_cluster, label = 행정읍면동)) +
  geom_point(size = 3) +
  geom_text(vjust = 1.5, hjust = 1.2, size = 3) +
  labs(title = "K-medoids Clustering: 주차수요지수 vs 주차부족지수",
       x = "주차수요지수",
       y = "주차부족지수") +
  theme_minimal() +
  scale_color_discrete(name = "군집")


# 필요한 패키지 설치 및 로드
install.packages("randomForest")
library(randomForest)

# 랜덤 포레스트 모델 학습
set.seed(123) # 재현 가능성을 위한 시드 설정
rf_model <- randomForest(주차부족지수 ~ 경제지수 +수요량 + 주차수요지수 + 인프라지수 + 수용지수, data = df, importance = TRUE)

# 모델 요약
print(rf_model)

# 변수 중요도 시각화
importance_values <- importance(rf_model)
varImpPlot(rf_model)
predicted_values <- predict(rf_model, df)

# 필요한 패키지 설치 및 로드
install.packages("dplyr")
library(dplyr)

target_areas <- c("강남동", "내곡동", "홍제동", "포남2동", "성덕동", "교1동")
ranked_df <- df %>%
  filter(행정읍면동 %in% target_areas) %>%
  mutate(Z = 수요량 * 0.35 + 
           주차수요지수 * 0.3 + 
           수용지수 * 0.19 + 
           경제지수 * 0.14 + 
           인프라지수 * 0.02) %>%
  arrange(desc(Z)) %>%
  mutate(Rank = row_number())  # 순위 매기기
print(ranked_df[, c("행정읍면동", "Z", "Rank")])


