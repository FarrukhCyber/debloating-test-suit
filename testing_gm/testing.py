import numpy as np
import pyautogui
import imutils
import cv2
import os
import subprocess
import time
from subprocess import Popen, PIPE

passed = 0
failed = 0
sleep_time = 1

bin_name = 'gm'
flags = ['flip','flop' , 'negate', 'contrast' , 'monochrome']
bin_flags = ['gm_slash_flip','gm_slash_flop','gm_slash_negate','gm_slash_contrast','gm_slash_monochrome']
images = ['test1.jpeg','test2.png','test3.tiff']

def mse(imageA, imageB):
	err = np.sum((imageA.astype("float") - imageB.astype("float")) ** 2)
	err /= float(imageA.shape[0] * imageA.shape[1])
	return err


for j in range(len(images)):
    for i in range(len(flags)):
        cmd = ['./'+ bin_name, 'display','-'+flags[i], images[j]]
        subprocess.Popen(cmd,
                            stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE)


        time.sleep(sleep_time)
        image3 = pyautogui.screenshot()
        image3 = cv2.cvtColor(np.array(image3), cv2.COLOR_RGB2BGR)
        cv2.imwrite("image3.png", image3)

        proc=subprocess.Popen('ps aux | grep ' + bin_name + ' | head -1', shell=True, stdout=subprocess.PIPE,)
        output=proc.communicate()[0]
        output = output.decode("utf-8")
        output = output.split(" ")
        os.system("kill -9 " + output[6])

        # -------------------------------------------------------------------------------

        time.sleep(sleep_time)
        cmd = ['./' + bin_flags[i], images[j]]
        subprocess.Popen(cmd,
                            stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE)

        time.sleep(sleep_time)
        image2 = pyautogui.screenshot()
        image2 = cv2.cvtColor(np.array(image2), cv2.COLOR_RGB2BGR)
        cv2.imwrite("image2.png", image2)

        proc=subprocess.Popen('ps aux | grep ' + bin_name + ' | head -1', shell=True, stdout=subprocess.PIPE,)
        output=proc.communicate()[0]
        output = output.decode("utf-8")
        output = output.split(" ")
        os.system("kill -9 " + output[6])

        if mse(image2,image3) < 10:
            print("Passed for flag =", flags[i], "and image type =", images[j])
            passed +=1
        else:
            print("failed for flag =", flags[i], "and image type =", images[j])
            failed +=1

print("Total tests:", passed+ failed)
print("Total passed:", passed)
print("Total failed:", failed)
















