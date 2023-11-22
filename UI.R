ui<-fluidPage( 
  dashboardPage( skin = "blue",
                 dashboardHeader(title = "Informasi Virus Korona", titleWidth = 230),
                 dashboardSidebar(
                   sidebarMenu(id = 'sidebarmenu',
                               # first menu item
                               menuItem("Coronavirus (?)", tabName = "penjelasan1", icon = icon("question-circle")),
                               # second menu item with 2 sub menus
                               menuItem('chart',
                                        icon = icon('bar-chart-o'),
                                        menuSubItem('Sebaran di Indonesia',
                                                    tabName = 'chart1',
                                                    icon = icon('line-chart')),
                                        menuSubItem('Sebaran di Dunia',
                                                    tabName = 'chart2',
                                                    icon = icon('line-chart'))),
                               menuItem("Database", tabName = "db", icon = icon("database"))
                   )),
                 dashboardBody(
                   
                   tabItems(
                     tabItem("penjelasan1", h2("Covid-19"), h4("Coronavirus atau virus corona merupakan keluarga besar virus yang menyebabkan infeksi saluran pernapasan atas ringan hingga sedang, seperti penyakit flu, banyak orang terinfeksi virus ini.", align = "justify"),
                                               h4("Jika dilihat berdasarkan usia, kelompok usia >60 tahun memiliki persentase angka kematian yang lebih tinggi dibandingkan kelompok usia lainnya. Sedangkan, bila dilihat dari jenis kelamin, 52,3 % penderita yang meninggal akibat COVID-19 adalah laki-laki dan 47,7% sisanya adalah perempuan.", align = "justify"),
                                               h4("Saat ini, Indonesia sedang menjalankan program vaksinasi COVID-19 secara bertahap. Vaksinasi COVID-19 bertujuan untuk membentuk kekebalan tubuh terhadap virus Corona. Selain itu, vaksinasi juga bertujuan untuk membentuk kekebalan kelompok atau herd immunity. Dengan begitu, masyarakat yang tidak dapat menjalani vaksin karena memiliki kondisi tertentu, seperti reaksi alergi berat terhadap vaksin, dapat terlindungi.", align = "justify"),
                             mainPanel(
                               img(src="banner.png", height = 370, width = 800)
                             )),
           
                      
                      tabItem(tabName = "chart1",
                             # First Row
                             fluidRow(box(title = "Perbandingan Kasus positif dan Meninggal", plotlyOutput("plot1", height = 250), width = 12),
                                      box(title = "Perbandingan Kasus Korona Beberapa Negara", plotlyOutput("plot2", height = 250),
                                          width=6, solidHeader = F),
                                      box(title = "Hubungan Kasus Positif dan Meninggal", plotlyOutput("plot3", height = 250)
                                         ))),
                     tabItem(tabName = "chart2",
                             # First Row
                             fluidRow(box(title = "Box with a plot", plotlyOutput("plot4", height = 450)), width = 12)),
                     tabItem(tabName = "db",
                             # First Row
                             fluidRow(tabBox(id="tabchart1",
                                             tabPanel("World",DT::dataTableOutput("Tab1", height = "450px"), width = 9),
                                             tabPanel("Indonesia",DT::dataTableOutput("Tab2", height = "450px"), width = 9), width = 12)))
                   ))))