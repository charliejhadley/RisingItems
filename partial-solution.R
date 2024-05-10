generate_country_urls <- function(selected_date, countries){
  
  # Get the selected date from input
  # Calculate the starting point as 3 months before the selected date
  # 
  # 
  selected_date <- ymd(selected_date)
  
  start_date <- selected_date %m-% months(2)
  formatted_start_date <- format(start_date, "%b+%Y")
  formatted_date <- format(selected_date, "%b+%Y")
  
  # Stitch the formatted start date and end date into the file_url
  files_urls <- 
    map_df(countries, 
        
        ~list(
          country_name = .x,
          country_data_url = paste0("https://irus.jisc.ac.uk/r5/report/item/irus_ir_master/?sort_column=Reporting_Period_Total&sort_order=DESC&begin_date=",
                     formatted_start_date, "&end_date=", formatted_date,
                     "&items=100&report_requested=1&institution%5B0%5D=2&repository%5B0%5D=2&access_method%5B0%5D=1&access_type%5B0%5D=4&data_type%5B0%5D=12&item_type%5B0%5D=23&item_type%5B1%5D=0&item_type%5B2%5D=26&item_type%5B3%5D=1&item_type%5B4%5D=2&item_type%5B5%5D=3&item_type%5B6%5D=4&item_type%5B7%5D=5&item_type%5B8%5D=30&item_type%5B9%5D=6&item_type%5B10%5D=7&item_type%5B11%5D=28&item_type%5B12%5D=8&item_type%5B13%5D=9&item_type%5B14%5D=22&item_type%5B15%5D=10&item_type%5B16%5D=25&item_type%5B17%5D=27&item_type%5B18%5D=11&item_type%5B19%5D=12&item_type%5B20%5D=13&item_type%5B21%5D=14&item_type%5B22%5D=15&item_type%5B23%5D=16&item_type%5B24%5D=17&item_type%5B25%5D=18&item_type%5B26%5D=24&item_type%5B27%5D=29&item_type%5B28%5D=19&item_type%5B29%5D=20&item_type%5B30%5D=21&metric_type%5B0%5D=10&output%5B0%5D=13&format=json", "&country%5B0%5D=", .x)
          
          ))
  
  files_urls
}


generate_country_urls("2024-01-01", c("BM", "GB")) 


get_irus_data <- function(country_data_tib){
  
  country_data_tib %>% 
    as.list() %>% 
    future_map(~{
      download.file(.country_data_url, "foobar.json")
    })
  
}

generate_country_urls("2024-01-01", c("BM", "GB")) %>% 
  get_irus_data()
