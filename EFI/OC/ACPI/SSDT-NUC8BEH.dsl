/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASLoVOIQO.aml, Wed Dec 23 14:09:25 2020
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000360 (864)
 *     Revision         0x02
 *     Checksum         0x31
 *     OEM ID           "HACK"
 *     OEM Table ID     "HackLife"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20200925 (538970405)
 */
DefinitionBlock ("", "SSDT", 2, "HACK", "HackLife", 0x00000000)
{
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.LPCB, DeviceObj)
    External (_SB_.PCI0.LPCB.H_EC._STA, UnknownObj)
    External (_SB_.PCI0.LPCB.MATH._STA, UnknownObj)
    External (_SB_.PCI0.PEG0, DeviceObj)
    External (_SB_.PCI0.RP05, DeviceObj)
    External (_SB_.PCI0.RP05.PXSX, DeviceObj)
    External (_SB_.PCI0.RP15.PXSX._STA, UnknownObj)
    External (_SB_.PCI0.SBUS, DeviceObj)
    External (_SB_.PCI0.XDCI.DVID, FieldUnitObj)
    External (_SB_.PR00, ProcessorObj)
    External (DVID, UnknownObj)
    External (STAS, UnknownObj)

    Name (RMDA, One)
    Scope (_SB)
    {
        Scope (PR00)
        {
            If (_OSI ("Darwin"))
            {
                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If ((Arg2 == Zero))
                    {
                        Return (Buffer (One)
                        {
                             0x03                                             // .
                        })
                    }

                    Return (Package (0x02)
                    {
                        "plugin-type", 
                        One
                    })
                }
            }
        }

        Device (USBX)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If ((Arg2 == Zero))
                {
                    Return (Buffer (One)
                    {
                         0x03                                             // .
                    })
                }

                Return (Package (0x08)
                {
                    "kUSBSleepPowerSupply", 
                    0x13EC, 
                    "kUSBSleepPortCurrentLimit", 
                    0x0834, 
                    "kUSBWakePowerSupply", 
                    0x13EC, 
                    "kUSBWakePortCurrentLimit", 
                    0x0834
                })
            }
        }

        Scope (PCI0)
        {
            Name (RP15.PXSX._STA, Zero)  // _STA: Status
            Device (RP15.SDXC)
            {
                Name (_ADR, Zero)  // _ADR: Address
            }

            Scope (LPCB)
            {
                Device (EC)
                {
                    Name (_HID, "ACID0001")  // _HID: Hardware ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (_OSI ("Darwin"))
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }

                Device (PMCR)
                {
                    Name (_HID, EisaId ("APP9876"))  // _HID: Hardware ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (_OSI ("Darwin"))
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }

                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        Memory32Fixed (ReadWrite,
                            0xFE000000,         // Address Base
                            0x00010000,         // Address Length
                            )
                    })
                }
            }
        }
    }

    Method (_SB.PCI0.XDCI._STA, 0, NotSerialized)  // _STA: Status
    {
        If ((DVID != 0xFFFF))
        {
            Return (0x0F)
        }
        Else
        {
            Return (Zero)
        }
    }

    Method (DTGP, 5, NotSerialized)
    {
        If ((Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b") /* Unknown UUID */))
        {
            If ((Arg1 == One))
            {
                If ((Arg2 == Zero))
                {
                    Arg4 = Buffer (One)
                        {
                             0x03                                             // .
                        }
                    Return (One)
                }

                If ((Arg2 == One))
                {
                    Return (One)
                }
            }
        }

        Arg4 = Buffer (One)
            {
                 0x00                                             // .
            }
        Return (Zero)
    }

    Scope (\)
    {
        If (_OSI ("Darwin"))
        {
            \_SB.PCI0.LPCB.H_EC._STA = Zero
            If (CondRefOf (\_SB.PCI0.LPCB.RTC._STA))
            {
                STAS = One
            }

            \_SB.PCI0.LPCB.MATH._STA = 0x0F
        }
    }
}

