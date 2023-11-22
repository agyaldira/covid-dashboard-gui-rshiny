server<-shinyServer(function(input, output, session){
  
  
  ## Plotly Scatter Plot
  df_indo <- coronavirus %>%
    dplyr::filter(country == "Indonesia")
  df_I_con <- df_indo %>%
    dplyr::filter(type == "confirmed")
  df_I_dth <- df_indo %>%
    dplyr::filter(type == "death")
  output$plot3 <- renderPlotly({
    plot_ly(x=df_I_con$cases, 
            y=df_I_dth$cases, color = "#8FBC8F",
            type = "scatter",
            mode = "markers")
    
  })
  #membandingkan kasus beberapa negara
   output$plot2 <- renderPlotly({
    
    df <- coronavirus %>%
      dplyr::group_by(country, type) %>%
      dplyr::summarise(total = sum(cases)) %>%
      tidyr::pivot_wider(
        names_from = type,
        values_from = total
      )
    
    #membandingkan kasus
    konfirmasi_harian <- coronavirus %>%
      dplyr::filter(type == "confirmed") %>%
      dplyr::filter(date >= "2020-06-25") %>%
      dplyr::mutate(country = country) %>%
      dplyr::group_by(date, country) %>%
      dplyr::summarise(total = sum(cases)) %>%
      dplyr::ungroup() %>%
      tidyr::pivot_wider(names_from = country, values_from = total)
    konfirmasi_harian %>%
      plotly::plot_ly() %>%
      plotly::add_trace(
        x = ~date,
        y = ~Austria,
        type = "scatter",
        mode = "lines+markers",
        name = "Austria"
      ) %>%
      plotly::add_trace(
        x = ~date,
        y = ~Philippines,
        type = "scatter",
        mode = "lines+markers",
        name = "Philippines"
      ) %>%
      plotly::add_trace(
        x = ~date,
        y = ~Singapore,
        type = "scatter",
        mode = "lines+markers",
        name = "Singapore"
      ) %>%
      plotly::add_trace(
        x = ~date,
        y = ~Indonesia,
        type = "scatter",
        mode = "lines+markers",
        name = "Indonesia"
      ) %>%
      plotly::layout(
        title = "",
        legend = list(x = 0.1, y = 0.9),
        yaxis = list(title = "Kasus Positif"),
        xaxis = list(title = "Tanggal"),
        hovermode = "compare",
        margin = list(
          b = 10,
          t = 10,
          pad = 2
        )
      )
    
  })
   
  ## Plot terkonfirmasi positif dan meninggal
  output$plot1 <- renderPlotly({##tampilkan data
    df <- coronavirus %>%
      dplyr::filter(country == "Indonesia") %>%
      dplyr::group_by(country, type) %>%
      dplyr::summarise(total = sum(cases))
    ##Panggil nama tabel
    #untuk mempercantik tabel
    df <- coronavirus %>%
      # dplyr::filter(date == max(date)) %>%
      dplyr::filter(country == "Indonesia") %>%
      dplyr::group_by(country, type) %>%
      dplyr::summarise(total = sum(cases)) %>%
      tidyr::pivot_wider(
        names_from = type,
        values_from = total
      ) 
    
    #melihat kasus corona perhari 
    ##Data Harian
    df_harian <- coronavirus %>%
      dplyr::filter(country == "Indonesia") %>%
      dplyr::filter(date >= "2020-03-01") %>% 
      dplyr::group_by(date, type) %>%
      dplyr::summarise(total = sum(cases, na.rm = TRUE)) %>%
      tidyr::pivot_wider(
        names_from = type,
        values_from = total
      ) %>%
      dplyr::arrange(date) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(active = confirmed - death) %>%
      dplyr::mutate(
        confirmed_cum = cumsum(confirmed),
        death_cum = cumsum(death),
        active_cum = cumsum(active)
      )
    
    ##Plot Data Harian (mati dan terkonfirmasi)
    confirmed_color <- "purple"
    active_color <- "#7FFFD4"
    recovered_color <- "forestgreen"
    death_color <- "##B22222"
    plotly::plot_ly(data = df_harian) %>%
      plotly::add_trace(
        x = ~date,
        # y = ~active_cum,
        y = ~confirmed_cum,
        type = "scatter",
        mode = "lines+markers",
        name = "Terkonfirmasi Positif",
        line = list(color = active_color),
        marker = list(color = active_color)
      ) %>%
      plotly::add_trace(
        x = ~date,
        y = ~death_cum,
        type = "scatter",
        mode = "lines+markers",
        name = "Meninggal",
        line = list(color = death_color),
        marker = list(color = death_color)
      ) %>%
      plotly::add_annotations(
        x = as.Date("2020-03-02"),
        y = 1,
        text = paste("Kasus Pertama"),
        xref = "x",
        yref = "y",
        arrowhead = 5,
        arrowhead = 3,
        arrowsize = 1,
        showarrow = TRUE,
        ax = -10,
        ay = -80
      ) %>%
      plotly::add_annotations(
        x = as.Date("2020-03-11"),
        y = 3,
        text = paste("Kematian Pertama"),
        xref = "x",
        yref = "y",
        arrowhead = 5,
        arrowhead = 3,
        arrowsize = 1,
        showarrow = TRUE,
        ax = -90,
        ay = -90
      ) %>%
      plotly::layout(
        title = "",
        yaxis = list(title = "Kasus Positif"),
        xaxis = list(title = "Tanggal"),
        legend = list(x = 0.1, y = 0.9),
        hovermode = "compare"
      )
    
  })
  
  ## tabel selanjutnya jika ingin dimasukkan
  output$plot4 <- renderPlotly({
  })
  
  ## tabel 1
  output$Tab1 <- DT::renderDataTable(DT::datatable({
    data <-coronavirus }))
  ## tabel 2
  output$Tab2 <- DT::renderDataTable(DT::datatable({
    #filter indo
    df_indo <- coronavirus %>%
      dplyr::filter(country == "Indonesia") %>%
      dplyr::filter(date >= "2020-03-01") %>% 
      dplyr::group_by(date, type) %>%
      dplyr::summarise(total = sum(cases, na.rm = TRUE)) %>%
      tidyr::pivot_wider(
        names_from = type,
        values_from = total
      ) %>%
      dplyr::arrange(date) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(active = confirmed - death) %>%
      dplyr::mutate(
        confirmed_cum = cumsum(confirmed),
        death_cum = cumsum(death),
        active_cum = cumsum(active)
      )
    data <-df_indo }))
  
})