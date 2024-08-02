//
//  Constants.swift
//  Euki
//
//  Created by Víctor Chávez on 5/31/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

enum CalendarCategory: Int {
    case bleeding = 0,
    emotions, body, sexualActivity, contraception, test, appointment, note
}

enum BleedingSize: Int {
    case spoting = 0,
    light, medium, heavy
}

enum BleedingClot: Int {
	case small = 0,
	big
}

let bleedingProductsUIOrder = [BleedingProducts.reusablePad, BleedingProducts.disposablePad, BleedingProducts.tampon, BleedingProducts.menstrualCup, BleedingProducts.menstrualDisc, BleedingProducts.periodUnderwear, BleedingProducts.liner]

enum BleedingProducts: Int {
    case disposablePad = 0,
    liner, tampon, menstrualCup, periodUnderwear, reusablePad, menstrualDisc
}

enum Emotions: Int {
    case calm = 0,
    stressed, unmotivated, sad, happy, irritable, angry, energetic, horny
}

enum Body: Int {
    case acne = 0,
    bloating, cramps, cravings, discharge, fatigue, fever, headache, itchy, nausea, severePain, stomachache, tenderBreasts, ovulation
}

enum SexualProtectionSTI: Int {
    case protected = 0,
    unprotected
}

enum SexualProtectionPregnancy: Int {
    case protected = 0,
    unprotected
}

enum SexualProtectionOther: Int {
    case masturbation = 0,
    oralSex, orgasm, sexToys, analSex
}

enum ContraceptionPills: Int {
    case took = 0,
    missed, double
}

enum ContraceptionDailyOther: Int {
    case condom = 0,
    diaphragm, cervicalCup, sponge, spermicide, withdrawal, emergency
}

enum ContraceptionIUD: Int {
    case new = 0,
    checkedStrings, removed
}

enum ContraceptionImplant: Int {
    case new = 0,
    removed
}

enum ContraceptionPatch: Int {
    case new = 0,
    removed
}

enum ContraceptionRing: Int {
    case new = 0,
    removed
}

enum ContraceptionLongTermOther: Int {
    case injection = 0
}

enum ContraceptionShot: Int {
    case shot = 0
}

enum TestSTI: Int {
    case positive = 0,
    negative
}

enum TestPregnancy: Int {
    case positive = 0,
    negative
}

class Constants {
    static let FontLineSpacingMultiplier: CGFloat = 1.4
	static let DaysBleedingTrackingAlert: Int = 14
	static let MinDaysBetweenPeriods: Int = 3
    static let defaultReferenceScreenWidth: CGFloat = 375.0
}
