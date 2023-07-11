################################################################################
# read csv file
################################################################################
read_xxx_csv <- function() {
    csv_data <- read_csv("data/xxx.csv", locale = locale("ko", encoding = "euc-kr"))

    return(csv_data)
}

################################################################################
# read json file
################################################################################
read_xxx_json <- function() {
    json_data <- fromJSON(file = "data/xxx.json")

    return(json_data)
}
