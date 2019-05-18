#-----------------------------------------------------------------------
# Line차트 자세히 알아보기
# x축 인코딩 되는 데이터 타입이 numeric/date vs. character/factor
# 위 사항에 따라 group 파라미터의 기능이 달리짐. 중요!!!
# 라인의 목적은 연속형 변수의 경향성 확인. 즉 x축 데이터타입은 연속형!
#-----------------------------------------------------------------------
library(tidyverse)

df.line <- tibble(
    x1 = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10),
    y1 = c(50, 25, 13, 29, 83, 100, 66, 34, 56, 2),
    category = c("a", "a", "a", "a", "a", "a", "a", "a", "a", "a")
)

ggplot(df.line, aes(x = x1, y = y1)) +
    geom_line() #아무런 문제 없이 그려짐.

# 카테고리를 두 세트로 만들어보자
# 각 점들을 어떻게 연결할 것인지 고민의 시작
df.line2 <- tibble(
    x2 = rep(1:10, times = 2),
    y2 = round(runif(20, 0, 100), 1),
    category = c(rep("a", 10), rep("b", 10))
)

df.line2 %>% 
    ggplot(aes(x = x2, y = y2)) +
    geom_line() #카테고리 구분 없이 점을 연결

df.line2 %>% 
    ggplot(aes(x = x2, y = y2, color = category)) +
    geom_line() #카테고리 구분 없이 점을 연결


#df.line2의 x를 character로 바꾸주고 x aesthetics에 인코딩
#x축 라벨링의 이슈가 발생(순서 뒤죽박죽)
df.line3 <- tibble(
    x2 = as.character(rep(1:10, times = 2)),
    y2 = round(runif(20, 0, 100), 1),
    category = c(rep("a", 10), rep("b", 10))
)

df.line3 %>% 
    ggplot(aes(x = x2, y = y2)) +
    geom_line() #df.line2와 다르게 x축 요소끼리만 연결

df.line3 %>% 
    ggplot(aes(x = x2, y = y2, group = category)) +
    geom_line() #group을 해주면 그려짐

df.line3 %>% 
    ggplot(aes(x = x2, y = y2, color = category)) +
    geom_line() #color만 해주면 실패

df.line3 %>% 
    ggplot(aes(x = x2, y = y2, group = 1)) +
    geom_line() #group = 1로 해주면 점의 구분 없이 연결

df.line3 %>% 
    ggplot(aes(x = x2, y = y2, color = category, group = category)) +
    geom_line() #group과 color 모두 지정하면 그려짐
