# Guide on How to Set Up HP Servers

#### Specific Models:
- HP ProLiant DL380p Gen8
- HP ProLiant DL320e Gen8


## Info

#### Reduce Fan Noise
Refer to this guide: [HP iLO4 v2.77 - Unlocked Access to Fan Controls](https://www.reddit.com/r/homelab/comments/sx3ldo/hp_ilo4_v277_unlocked_access_to_fan_controls/)
WebUI to control it: [iLO Fan Control](https://github.com/alex3025/ilo-fans-controller/tree/main)
#### SSH into iLO4
`ssh -o KexAlgorithms=+diffie-hellman-group14-sha1 -o HostKeyAlgorithms=+ssh-rsa username@hostname` [[Link](https://www.incredigeek.com/home/troubleshooting-ssh-no-matching-key-exchange-host-key-method-type-found-errors/)]

#### Types of Firmware Updates

##### iLO4 (Integrated Lights Out 4)
- Remote server management.  
  Download here: [HPE iLO4 Drivers & Software](https://support.hpe.com/connect/s/product?language=en_US&kmpmoid=5219994&tab=driversAndSoftware)

##### BIOS
- File formats: `.bin` or `.rpm` (extract `.6B8` from `.rpm`).
- Upload/Flash via iLO.

##### SPP (Service Pack for ProLiant)
- Provides automatic or interactive firmware updates.
- Includes tools like:
  - **SSA (Smart Storage Administrator)**: Used to configure the RAID Controller or enable HBA Mode.

##### Intelligent Provisioning Recovery Media
- Useful if iLO or F10 Smart Tools are not working.  
  Download here: [Intelligent Provisioning Recovery Media](https://support.hpe.com/connect/s/softwaredetails?language=en_US&softwareId=MTX_bf5521c396f2440bb0cb5efa87&tab=releaseNotes)

---

### Outdated/Unsupported TLS/SSL Version when trying to access iLO4 (ERR_SSL_PROTOCOL_ERROR)

**Solution:**
1. Download an old version of Firefox (ideally on a VM or sandbox) from the following link:  
   [https://ftp.mozilla.org/pub/firefox/releases/](https://ftp.mozilla.org/pub/firefox/releases/)
2. Use the old Firefox version to access iLO4.
3. Update iLO4 to the latest version.
4. Access iLO4 from a modern browser after the update.

