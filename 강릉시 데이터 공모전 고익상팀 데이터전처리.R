# 주차장 면적 데이터
parking_area <- c(843.14, 6838.916277, 15913.32271, 4339.84, 6891.3, 439.86, 827.36, 
                  662.99, 2171.62, 1889.99, 3840.81, 6393.34, 2929.15, 5529.47, 
                  28904.69, 19963.14, 7632.25, 5950.87, 818.81, 5931.57)

# 등록 차량 수 데이터
registered_vehicles <- c(9457, 2619, 6582, 19989, 4186, 3195, 8616, 3152, 
                         15752, 2369, 5620, 3876, 2190, 1740, 7787, 2239, 
                         2634, 5695, 6498, 8405)

# 주차장 수용대수 계산 (한 대당 12.5㎡)
parking_capacity <- parking_area / 12.5

# 수용률 계산
occupancy_rate <- (parking_capacity / registered_vehicles) * 100

# 결과 출력
occupancy_rate


parking_demand <- registered_vehicles - parking_capacity

# 결과 출력
parking_demand


# 주차 공급량 계산 (한 대당 12.5㎡)
parking_supply <- parking_area / 12.5

# 주차 부족지수 계산
parking_shortage_index <- parking_demand - parking_supply

# 결과 출력
result <- data.frame(읍면동 = c("강남동", "강동면", "경포동", "교1동", "교2동",
                             "구정면", "내곡동", "사천면", "성덕동", "성산면",
                             "송정동", "연곡면", "옥계면", "옥천동", "주문진읍",
                             "중앙동", "초당동", "포남1동", "포남2동", "홍제동"),
                     주차공급량 = parking_supply,
                     수요량 = parking_demand,
                     주차부족지수 = parking_shortage_index)

print(result)
