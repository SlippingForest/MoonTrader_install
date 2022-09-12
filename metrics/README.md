### port 48620
```bash
wget -O - https://raw.githubusercontent.com/SlippingForest/MoonTrader_install/master/metrics/install.sh | bash <(cat) </dev/tty
```



```bash
wget -O - https://raw.githubusercontent.com/SlippingForest/MoonTrader_install/master/metrics/install_core.sh | bash <(cat) </dev/tty
```
`systemctl status metrics-mtcore-server`
`systemctl start metrics-mtcore-server`
`systemctl stop metrics-mtcore-server`