import streamlit as st
import plotly.express as px
import pandas as pd
from sqlalchemy import create_engine
from connector import connect_to, read_credentials


@st.cache_data
def load_data(query):
    connection_string = read_credentials()
    engine = create_engine(connection_string)
    with engine.connect() as conn:
        df = pd.read_sql(query, conn)
    return df

invoice_query = """
SELECT invoice_date, total, billing_country
FROM invoice
"""
genre_query = """
SELECT i.total, g.name AS genre_name
FROM invoice i
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
"""

# ####
invoice_df = load_data(invoice_query)
genre_df = load_data(genre_query)


st.sidebar.header("Глобальные фильтры")
start_date = st.sidebar.date_input("Дата начала", pd.to_datetime(invoice_df['invoice_date']).min())
end_date = st.sidebar.date_input("Дата конца", pd.to_datetime(invoice_df['invoice_date']).max())


filtered_invoice_df = invoice_df[(invoice_df['invoice_date'] >= pd.to_datetime(start_date)) &
                                 (invoice_df['invoice_date'] <= pd.to_datetime(end_date))]


st.subheader("Линейный график: Сумма продаж по дате")
country_filter = st.selectbox("Выберите страну", options=filtered_invoice_df['billing_country'].unique())


line_chart_df = filtered_invoice_df[filtered_invoice_df['billing_country'] == country_filter]

fig_line = px.line(line_chart_df, x='invoice_date', y='total', title=f"Продажи по дате для {country_filter}")
st.plotly_chart(fig_line)

st.subheader("Столбчатая диаграмма: Сумма по жанрам")
genre_filter = st.multiselect("Выберите жанр", options=genre_df['genre_name'].unique(), default=genre_df['genre_name'].unique())


bar_chart_df = genre_df[genre_df['genre_name'].isin(genre_filter)]

fig_bar = px.bar(bar_chart_df, x='genre_name', y='total', title="Разбивка суммы по жанрам")
st.plotly_chart(fig_bar)
