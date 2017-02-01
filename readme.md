# Readme

We recommend making changes in the extension views (sf\_\_\*) rather than in the
corresponding base views (sfbase\_\_\*), so you can quickly regenerate the base
views as needed when database structure changes without overwriting your changes


In a few places, "query_timezone"s have been commented out. You may want to 
update them in case you want the dashboards to use a default different from 
what has been configured by the administrator or users.

## References:
- [Segment's information on this "source"](https://segment.com/docs/sources/cloud-apps/salesforce/)
- [PDF of the schema tables](https://www.lucidchart.com/publicSegments/view/06c1e292-285b-4d0d-a5cd-fc0940ec5ec2)