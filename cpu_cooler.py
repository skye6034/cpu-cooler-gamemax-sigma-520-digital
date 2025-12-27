#!/usr/bin/python3
import hid, psutil, time

VID, PID = 0x5131, 0x2007

def get_temp():
    t = psutil.sensors_temperatures()
    res = t.get('k10temp') or t.get('coretemp')
    return int(res[0].current) if res else 0

def run_display():
    while True:
        device = hid.device()
        try:
            print("Attempting to connect...")
            device.open(VID, PID)
            print("Connected!")
            
            while True:
                temp = get_temp()
                # Use the byte sequence that worked for you
                device.write([0x00, 0x01, temp, 0, 0, 0, 0, 0])
                time.sleep(2)
                
        except (IOError, OSError):
            print("Connection lost. Retrying in 5 seconds...")
            device.close()
            time.sleep(5)
        except KeyboardInterrupt:
            device.close()
            return

if __name__ == "__main__":
    run_display()
