import streamlit as st
import plotly.express as px
import pandas as pd
from connector import connect_to

# Заголовок дашборда
st.title('Chinook Sales Report')

# SQL запрос для получения данных из таблицы invoice
query = "SELECT * FROM invoice"
data = connect_to(query)


# Визуализация данных с использованием Plotly
# Первый график: Общая сумма по каждому пользователю
fig1 = px.bar(data, x="CustomerId", y="Total", title="Total Sales by Customer")

# Второй график: Распределение продаж по странам
fig2 = px.pie(data, names="BillingCountry", values="Total", title="Sales Distribution by Country")

# Элементы управления в боковой панели
st.sidebar.header('Filter Controls')

# Управление фильтром по диапазону дат
date_range = st.sidebar.slider(
    "Select Date Range",
    min_value=pd.to_datetime(data["InvoiceDate"]).min(),
    max_value=pd.to_datetime(data["InvoiceDate"]).max(),
    value=(pd.to_datetime(data["InvoiceDate"]).min(), pd.to_datetime(data["InvoiceDate"]).max())
)

# Управление фильтром по клиенту
customer_filter = st.sidebar.selectbox("Select Customer", options=data["CustomerId"].unique())

# Показать или скрыть датафрейм
show_df = st.sidebar.checkbox("Show DataFrame", value=True)

# Фильтруем данные по выбранным параметрам
filtered_data = data[(pd.to_datetime(data["InvoiceDate"]) >= date_range[0]) &
        (pd.to_datetime(data["InvoiceDate"]) <= date_range[1])]

if customer_filter:
    filtered_data = filtered_data[filtered_data["CustomerId"] == customer_filter]

# Отображение графиков
st.plotly_chart(fig1)
st.plotly_chart(fig2)

# Отображение датафрейма, если выбрано
if show_df:
    st.dataframe(filtered_data)
