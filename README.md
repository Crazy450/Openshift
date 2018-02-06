# Openshift 

This repository will be used to store Ansible Playbooks and documentation related to Openshift.

### Add secret to pod via env. variable
````
~~~~
env: 
- name: ADDITIONAL_CONF  # Name of the variable that will be consumed by the pod
  valueFrom:
    secretKeyRef:
      name: {{ Secret_Name }}  # Name of the secret
      key: {{ NameOfTheKey }}  # Name of the Key for the pod to consume the Value 
~~~
```
