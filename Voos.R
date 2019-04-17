path <- "C:/Users/jusou/Downloads/flight-delays" 

library(readr)
airlines = read_csv(file.path(path, "airlines.csv"))
airports = read_csv(file.path(path, "airports.csv"))
flights = read_csv(file.path(path, "flights.csv"))

atrasados <- flights %>% filter(!startsWith(ORIGIN_AIRPORT, "1")) %>% 
  unite(col="VOO", c("ORIGIN_AIRPORT", "DESTINATION_AIRPORT"), sep="-") %>%
  select(MONTH, VOO, ARRIVAL_DELAY) %>% 
  group_by(MONTH, VOO) %>% 
  summarise(ATRASO= mean(ARRIVAL_DELAY, na.rm=TRUE)) %>% 
  top_n(1)

atrasados <- atrasados %>% separate("VOO", into=c("ORIGEM","DESTINO"))
airports <- airports %>% select(IATA_CODE, AIRPORT, CITY)

atrasados <- left_join(atrasados, airports, by = c("ORIGEM"="IATA_CODE"))

names(atrasados)= c("MONTH", "ORIGEM", "DESTINO", "ATRASO", "AEROPORTO_ORIGEM", "CIDADE_ORIGEM")

atrasados <- left_join(atrasados, airports, by = c("DESTINO"="IATA_CODE")) 

names(atrasados)= c("MONTH", "ORIGEM", "DESTINO", "ATRASO", "AIRPORT_ORIGEM", "CITY_ORIGEM", "AIRPORT_DESTINO", "CITY_DESTINO")
atrasados