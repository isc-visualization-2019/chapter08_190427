library(tidyverse)

#------------------------------------------------
# Scatteor Plots
# geom_를 통해 얼마나 많은 차트 유형 있는지 확인
#------------------------------------------------

# 3개의 필수 레이어 중 2개만 사용
ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length, color = Species))

# 모든 필수 레이어 사용
ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length, color = Species)) +
  geom_point()

# histogram은 1개만 필요 x축
ggplot(mpg, aes(x = manufacturer)) +
  geom_histogram(stat = 'count')

# Scatter Plots의 목적은 관계를 볼 때 사용된다. 직접 그려보자
# 간혹 이렇게 흩어지지 않을 때도 있다
ggplot(mtcars, aes(x = cyl, y = wt)) +
  geom_point()

# geom_jitter는 붙어있는 값을 조금씩 흩트려 놓는다
ggplot(mtcars, aes(x = cyl, y = wt)) +
  geom_jitter()

# width값을 통해 적당하게 분산
ggplot(mtcars, aes(x = cyl, y = wt)) +
  geom_jitter(width = 0.1)

# jitter를 쓰는 또다른 방법
ggplot(mtcars, aes(x = cyl, y = wt)) +
  geom_point(position = position_jitter(0.1))

#-----------------------------------------------------
# 실습 : 폭염 일수 시각화
#-----------------------------------------------------
df_final2 <- read_csv("data/weather_practice.csv")
df_final2$category <- factor(df_final2$category, levels=c('max_temp','avg_temp','min_temp', 'humidity', 'angry_index'))

# vis1
ggplot(df_final2 %>% filter(category == "avg_temp" | category == "max_temp" | category == "min_temp"), 
       aes(x = dates, y = as.numeric(value), color = category)) +
  geom_jitter(alpha = .4) + 
  geom_smooth(method = "lm", color = "white") + 
  facet_grid(.~category) + 
  geom_hline(yintercept = 33, color = "grey")

a# vis2
ggplot(df_final2 %>% filter(category == "avg_temp" | category == "max_temp" | category == "min_temp"), 
       aes(x=dates, y=as.numeric(value), color = category)) +
  geom_jitter(alpha = .4) + geom_smooth(method = "lm", color = "white") + 
  geom_hline(yintercept = 33, color = "grey")

# vis3
ggplot(df_final2 %>% filter(category == "humidity"), aes(x = dates, y = value, color = category2)) +
  geom_point() + 
  geom_smooth(method = "lm")

# vis4
ggplot(df_final2 %>% filter(category == "min_temp" & value >= 25), aes(x = dates, y = value)) +
  geom_point(alpha = .4, size = 2, color = "red") +
  geom_smooth(method = "lm", se = FALSE, color = "grey")

# 실습 : mpg
str(diamonds)
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(alpha = .1 , position = "jitter", size = 0.01)

#------------------------------------------------
# Bar Plots
#------------------------------------------------
install.packages("gcookbook")
library(gcookbook)

#기본적인 Bar chart 만들기 첫번째 
ggplot(pg_mean, aes(x = group, y =weight)) + 
  geom_bar(stat = "identity")

#기본적인 Bar chart 만들기 두번째
ggplot(pg_mean, aes(x = group, y = weight)) +
  geom_col()

ggplot(pg_mean, aes(x = group, y = weight)) + 
  geom_col(fill = "#413FAC", colour="black")

# group bar chart를 만들어보자
ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) + 
  geom_col(position = "dodge")

# position = "stack"
ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) + 
  geom_col(position = "stack")

# position = "fill"
ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) + 
  geom_col(position = "fill")

#------------------------------------------------
# 예시 데이터로 살펴보기
#------------------------------------------------
df.test <- tibble(
  name = c("개", "고양이", "개", "오리", "닭", "닭", "닭", "고양이", "낙타", "개", "호랑이", "낙타", "낙타", "낙타",
           "호랑이", "고양이", "개", "고양이", "닭", "낙타", "낙타", "고양이", "호랑이", "개",
           "고양이", "닭", "낙타", "호랑이", "호랑이", "낙타", "개", "개", "개", "개", "개", "개", "개", "개")
)

# df.test는 동물별 몇마리인지 알 수는 없다
ggplot(df.test, aes(x = name)) +
  geom_bar()

# 에러: StatBin requires a continuous x variable: the x variable is discrete. Perhaps you want stat="count"?
# 이유는 geom_histogram()의 기본값 stat은 'identity'이기 때문에 이산 변수는 stat = "count"
ggplot(df.test, aes(x = name)) +
  geom_histogram()

# count함수로 계산 뒤에 다시 geom_col()로 그려보자. geom_col()은 y축 필수
# 에러: geom_col requires the following missing aesthetics: y
df.test2 <- df.test %>% 
  count(name)

df.test2 %>% 
  ggplot(aes(x = name, y = n)) +
  geom_col()

#------------------------------------------------
### next, histogram
#------------------------------------------------
# histogram을 그려보자
str(diamonds)

# 이산 변수 cut
ggplot(diamonds, aes(x = cut)) +
  geom_bar()

ggplot(diamonds, aes(x = cut)) +
  geom_histogram(stat = "count")

# 이산 변수 color
ggplot(diamonds, aes(x = color)) +
  geom_bar()

# 연속변수 depth를 geom_bar와 geom_histogram으로 비교해보자
# 이산변수(geom_bar)는 각 값을 카운팅 한 것이고, 연속변수(geom_histogram)는 범위안에 들어가는 것을 카운팅
ggplot(diamonds, aes(x = depth)) +
  geom_bar()

ggplot(diamonds, aes(x = depth)) +
  geom_histogram()

ggplot(diamonds, aes(x = depth)) +
  geom_histogram() +
  ylim(0, 25000)

ggplot(diamonds, aes(x = depth)) +
  geom_histogram(binwidth = 1.2) +
  ylim(0, 25000)

# binwidth = 4로 바꿔보자
ggplot(diamonds, aes(x = depth)) +
  geom_histogram(binwidth = 4)

# 기본적으로 geom_histogram에서 binwidth를 계산하는 방식 (bins = 30이 default)
diff(range(diamonds$depth)) / 30

# fill로 구분해보자
ggplot(diamonds, aes(price, fill = cut)) +
  geom_histogram(binwidth = 500)

# fill과 position을 함께 써보자
ggplot(diamonds, aes(price, fill = cut)) +
  geom_histogram(binwidth = 500, position = "dodge")

#--------------------------------------------------------------
# 라인그래프의 개념을 살펴보자
# 중요한 건 x축에 인코딩 되는 데이터 타입! 
#--------------------------------------------------------------
d <- data.frame(
  expand.grid(
    x <- letters[1:4],
    g <- factor(1:2)
  ),
  y = rnorm(8)
)
glimpse(d)

# Var1은 factor, Var2는 factor, y는 숫자
ggplot(d, aes(x=Var1, y=y, colour=Var2)) + geom_line() + geom_point()
ggplot(d, aes(x=Var1, y=y, colour=Var2, group=Var2)) + geom_line() + geom_point()
ggplot(d, aes(x=Var1, y=y, colour=Var2, group=1)) + geom_line() + geom_point()


# 내장데이터로 그려보자
ggplot(BOD, aes(x = Time, y = demand, group = 1)) + 
  geom_line()

glimpse(BOD)

# x축에 모든 x의 값이 표시됨, 6이 있나요?
BOD$Time <- factor(BOD$Time)
l1 <- ggplot(BOD, aes(x = Time, y = demand, group = 1)) + 
  geom_line()

# x축에 모든 x의 값이 표시됨, 6이 있나요?
BOD$Time <- factor(BOD$Time)
l2 <- ggplot(BOD, aes(x = Time, y = demand, group = 1)) + 
  geom_line() +
  ylim(0, max(BOD$demand))

# y축의 범위가 달라지면 기울기도 달라진다. 유의할 것!
gridExtra::grid.arrange(l1, l2, nrow = 1)

##### next
df_temp <- read_csv("data/line_temp.csv")

# 1960년과 1994년 추출
df_temp <- df_temp %>% 
  filter(year == 1994, category == "max_temp" | category == "min_temp")

ggplot(df_temp, aes(x = dates, y = value)) +
  geom_line() 

# 선의 색으로 구분
ggplot(df_temp, aes(x = dates, y = value, color = category)) +
  geom_line() +
  ylim(0, 40)

# 선의 타입으로 구분
ggplot(df_temp, aes(x = dates, y = value, linetype = category)) +
  geom_line() +
  ylim(0, 40)

# 나만의 색을 만들어보자
my_color <- c("#7F44F7", "#FDAC44")

# 응용해서 라인그래프를 만들어보자
ggplot(df_temp, aes(x = dates, y = value, color = category)) +
  geom_line() +
  ylim(0, 40) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  scale_color_manual(values = my_color)


#------------------------------------------------
# Line Plots의 응용 geom_area
#------------------------------------------------
ggplot(df_temp, aes(x = dates, y = value, fill = category)) +
  geom_ribbon(aes(ymin = 0, ymax = value), alpha = 0.5) +
  ylim(0, 40)

ggplot(df_temp, aes(x = dates, y = value, color = category)) +
  geom_area(alpha = 0.2, position = "dodge") +
  ylim(0, 40)


