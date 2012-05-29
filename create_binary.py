#!/usr/bin/env python

import os
import sys
import re

dir_binary   = 'binaries'
dir_vimfiles = '.vim'
descr_file   = 'binaries_description.txt'
linux        = True

debug = False

def deletePackages():
    s_exe = 'rm ' + dir_binary + '/' + '*.zip'
    os.system(s_exe)

def createPackage(p_name, p_files):
    s_exe = 'zip ' + '..' + "\\" + dir_binary + '/' + p_name + '.zip ' + " ".join(p_files) # " " - separate each list element by space
    if linux:
        s_exe = s_exe.replace('\\','/')
    print "exe str: " + s_exe
    #print 'yahoo, you in createPackage!\n'

    if debug:
        print 'p_name=' + p_name,'\nfiles:'
        for i in p_files:
            print i
        print 'exe str=' + s_exe
        print '\n'

    curr_path = os.getcwd()
    os.chdir(curr_path + '/' + dir_vimfiles)
    os.system(s_exe)                # exe command
    os.chdir(curr_path)
    print '\n'

    



packages_descr = open(dir_binary + '/' + descr_file,'r')

if not packages_descr:
    print 'sorry, cant open file:',descr_file
else:
    deletePackages()
    pack_name  = ''
    pack_files = []

    for i in packages_descr.readlines():
        if not re.match('^\#',i): # skip empty lines

            if re.match('^$',i) and pack_name != '' and len(pack_files) > 0: #create package on each empty line, if list is full and package name
                createPackage(pack_name,pack_files)
                pack_files[:] = [] #clear list
                pack_name     = ''

            i = i.rstrip() #remove \n from end of line
            res = re.search('^package=(.*)$',i)

            if res:
                pack_name = res.group(1)
            elif not re.match('^$',i):
                #print 'i=',i
                pack_files.append(i)
                #print 'pack_files len=',len(pack_files)
            #print i
