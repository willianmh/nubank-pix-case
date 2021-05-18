# nubank-pix-case

This repository contains the resolution of the "Nubank Analytics Engineer Case".

It was developed using MySQL v8.0.23.

## Get started

First of all, let's create our database

~~~ sql
CREATE DATABASE nubank;
~~~

Inside ***./queries*** folder you can find ***nu-warehouse.sql*** to create all tables and ***nu-warehouse-populate.sql*** to populate the tables with data from the csv files.

***Important:*** you **must** edit the ***nu-warehouse-populate.sql*** with the path to the csv in your local machine.

***Obs.:*** Note that your MySQL server should be able to load data from an arbritary folder.

~~~ bash
mysqld --init-file="~/my.ini"
~~~

You can find a sample of my.ini in this repository.

***Obs. 2:*** The idea was to implement a manager to automatically run the queries to create and populate the database, but unfortunatelly, I could finish before the submission date.

## ToDo

- [ ] Create a manager to set up db
- [x] Finish Jane
- [x] Finish ReadMe
- [x] Propose new model
- [x] Strategy to implement model
- [x] Metric to measure PIX

## Help Jane

The file containing the data Jane requested is in the ***./res*** folder.

The SQL statement to query the data can be found in ***./queries/jane.sql***.

## Proposing Model

To simplify the model, the three main tables containing transferences could be combined into a single one. Right now we have only two kinds of transfers: pix and normal transfers (maybe TED or DOC?). In future, or even to incorporate methods from differents countries, we could have more kinds. So as we add a new type of transfer, the model gets more complex.

Having a single table, we could differentiate the types, with a column *transfer type* for values like: ted, doc, pix, iban, etc...  And, similar to the pix table, we could have the *in_or_out* column (binary column) to store if the money was received or transfered out.

What would also be nice to have, are views to reduce queries complexity, since the data will be consumed not for only one user, but many users in many projects, and they are likely to use similar queries.

## Implementing model

We could create the model and a pipeline to transform the data. Then feed the model with data from the production enviroment. The model can be implemented with SQL, and the pipeline depends on the technology that the company use.

To create the views, at first would be nice to map current queries in use. Then, find commons transformations applied to data, or tables join's. 

## Metrics for PIX

To evaluate the usage of PIX, we could calculate the PIX rate over the time, we are evaluating pix popularity.

~~~
transfers_with_pix := count(transfer[id]) where transfer[kind] = "pix"
total_transfers := count(transfer[id])

pix_usage_rate := transfer_with_pix / total_transfers
~~~

and plot this information over the time with the time dimension. 

Together with the pix usage rate, would also be nice to measure the total amount per transfer, we are evaluating how people trust on pix.

~~~
amount_pix := sum(transfer[id]) where transfer[kind] = "pix"
total_amount := sum(transfer[id])

pix_amount_rate := amount_pix / total_amount
~~~

Now that we measured the popularity and the reliability of pix in general, we can explore individual measures, to focus in our customers. We could start thinking how to answer the following questions:

- What is the average transfer amount per customer? pix and total.
- What is the average increase/decrease (change) in the number of transfer made per users with the addition of pix.
- What is the average rate of pix usage per user?

The calculation of these question I let as an exercise for you ;)

All jokes aside, these question helps us to better understand from a customer perspective, how well people received the new method and the pix adherence.

## Conclusion

I hope I understood right what I was requested to do, and hope the presented solution can be usefull somehow. In any case, the experience to design and solve the case was amazing, and I would be more than happy to present :)

Regards