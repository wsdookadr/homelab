## RTC Sleep and Wake

set up rtc alarm for the nodes:

```
ansible-playbook -i inventory sleep_rtc.yml
```

wake them up:

```
ansible-playbook -i inventory wake.yml
```


