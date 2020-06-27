# Data Dictionary

The following tables describe the variables in each of the current data sets
along with a short desciption, the number of unique values of that variable and
the number of percentage of records for which that value is present (i.e. not
`NA`). To partially generate these tables run `make data-dictionary`.

## Epidemiology

| Variable         | Description | Distinct values | Completeness |
|------------------|-------------|-----------------|--------------|
| source           | TBC         |              38 |   100.000000 |
| date             | TBC         |             176 |   100.000000 |
| country          | TBC         |             216 |   100.000000 |
| countrycode      | TBC         |             207 |   100.000000 |
| adm_area_1       | TBC         |             887 |    94.537665 |
| adm_area_2       | TBC         |            2189 |    76.497373 |
| adm_area_3       | TBC         |             340 |     7.194550 |
| tested           | TBC         |           14930 |     5.726914 |
| confirmed        | TBC         |           20330 |    96.879301 |
| recovered        | TBC         |            6434 |    12.387637 |
| dead             | TBC         |            5142 |    81.792512 |
| hospitalised     | TBC         |            3835 |     6.782340 |
| hospitalised_icu | TBC         |            1253 |     6.283642 |
| quarantined      | TBC         |            1669 |     1.150141 |
| gid              | TBC         |            4788 |   100.000000 |

## Government Response

| Variable                              | Description | Distinct values | Completeness |
|---------------------------------------|-------------|-----------------|--------------|
| source                                | TBC         |               1 |   100.000000 |
| date                                  | TBC         |             173 |   100.000000 |
| gid                                   | TBC         |             188 |   100.000000 |
| country                               | TBC         |             178 |   100.000000 |
| countrycode                           | TBC         |             178 |   100.000000 |
| adm_area_1                            | TBC         |               1 |     0.000000 |
| adm_area_2                            | TBC         |               1 |     0.000000 |
| adm_area_3                            | TBC         |               1 |     0.000000 |
| c1_school_closing                     | TBC         |               5 |    96.444841 |
| c1_flag                               | TBC         |               3 |    51.802337 |
| c2_workplace_closing                  | TBC         |               5 |    96.444841 |
| c2_flag                               | TBC         |               3 |    46.560375 |
| c3_cancel_public_events               | TBC         |               4 |    96.392025 |
| c3_flag                               | TBC         |               3 |    53.013798 |
| c4_restrictions_on_gatherings         | TBC         |               6 |    96.250083 |
| c4_flag                               | TBC         |               3 |    46.672608 |
| c5_close_public_transport             | TBC         |               4 |    96.415132 |
| c5_flag                               | TBC         |               3 |    33.934112 |
| c6_stay_at_home_requirements          | TBC         |               5 |    96.448142 |
| c6_flag                               | TBC         |               3 |    42.249290 |
| c7_restrictions_on_internal_movement  | TBC         |               4 |    96.448142 |
| c7_flag                               | TBC         |               3 |    42.275698 |
| c8_international_travel_controls      | TBC         |               6 |    96.405229 |
| e1_income_support                     | TBC         |               4 |    96.491054 |
| e1_flag                               | TBC         |               3 |    30.243613 |
| e2_debtcontract_relief                | TBC         |               4 |    96.563676 |
| e3_fiscal_measures                    | TBC         |             410 |    96.167558 |
| e4_international_support              | TBC         |              55 |    96.286393 |
| h1_public_information_campaigns       | TBC         |               4 |    96.491054 |
| h1_flag                               | TBC         |               3 |    69.287648 |
| h2_testing_policy                     | TBC         |               5 |    96.431637 |
| h3_contact_tracing                    | TBC         |               4 |    96.520763 |
| h4_emergency_investment_in_healthcare | TBC         |             248 |    96.223675 |
| h5_investment_in_vaccines             | TBC         |              51 |    96.269888 |
| m1_wildcard                           | TBC         |               1 |     0.000000 |
| stringency_index                      | TBC         |             160 |    96.392025 |
| stringency_indexfordisplay            | TBC         |             160 |    98.775335 |
| stringency_legacy_index               | TBC         |             132 |    96.392025 |
| stringency_legacy_indexfordisplay     | TBC         |             132 |    98.775335 |
| government_response_index             | TBC         |             211 |    96.375520 |
| government_response_index_for_display | TBC         |             211 |    98.762131 |
| containment_health_index              | TBC         |             189 |    96.378821 |
| containment_health_index_for_display  | TBC         |             189 |    98.765432 |
| economic_support_index                | TBC         |              10 |    96.368918 |
| economic_support_index_for_display    | TBC         |              10 |    98.732422 |

## Mobility 

| Variable          | Description | Distinct values | Completeness |
|-------------------|-------------|-----------------|--------------|
| source            | TBC         |               2 |   100.000000 |
| date              | TBC         |             160 |   100.000000 |
| country           | TBC         |             138 |   100.000000 |
| countrycode       | TBC         |             138 |   100.000000 |
| adm_area_1        | TBC         |            1860 |   100.000000 |
| adm_area_2        | TBC         |            1841 |   100.000000 |
| adm_area_3        | TBC         |               1 |     0.000000 |
| transit_stations  | TBC         |             297 |    29.519734 |
| residential       | TBC         |              73 |    30.568379 |
| workplace         | TBC         |             226 |    54.053690 |
| parks             | TBC         |             497 |    25.481508 |
| retail_recreation | TBC         |             275 |    42.802809 |
| grocery_pharmacy  | TBC         |              73 |    30.568379 |
| gid               | TBC         |            4901 |   100.000000 |
| transit           | TBC         |               1 |     0.000000 |
| walking           | TBC         |               1 |     0.000000 |
| driving           | TBC         |           27129 |    43.384015 |
