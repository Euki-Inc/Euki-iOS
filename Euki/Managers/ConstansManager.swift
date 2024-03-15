//
//  ImageManager.swift
//  Euki
//
//  Created by Víctor Chávez on 10/21/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class ConstansManager: NSObject {
    static let sharedInstance = ConstansManager()
    
    //MARK: - String Methods
    
    func text(for bleedingSize: BleedingSize) -> String {
        return String(format: "bleeding_size_%d", bleedingSize.rawValue + 1).localized
    }
	
	func text(for bleedingClot: BleedingClot) -> String {
		return String(format: "bleeding_clots_%d", bleedingClot.rawValue + 1).localized
	}
    
    func text(for bleedingProduct: BleedingProducts) -> String {
        return String(format: "bleeding_produc_%d", bleedingProduct.rawValue + 1).localized
    }
    
    func text(for emotion: Emotions) -> String {
        return String(format: "emotions_%d", emotion.rawValue + 1).localized
    }
    
    func text(for body: Body) -> String {
        return String(format: "body_%d", body.rawValue + 1).localized
    }
    
    func text(for sexualActivity: SexualProtectionSTI) -> String {
        return String(format: "protection_sti_%d", sexualActivity.rawValue + 1).localized
    }
    
    func textList(for sexualActivity: SexualProtectionSTI) -> String {
        return String(format: "protection_sti_%d_list", sexualActivity.rawValue + 1).localized
    }
    
    func text(for sexualActivity: SexualProtectionOther) -> String {
        return String(format: "protection_other_%d", sexualActivity.rawValue + 1).localized
    }
    
    func text(for sexualActivity: SexualProtectionPregnancy) -> String {
        return String(format: "protection_pregnancy_%d", sexualActivity.rawValue + 1).localized
    }
    
    func textList(for sexualActivity: SexualProtectionPregnancy) -> String {
        return String(format: "protection_pregnancy_%d_list", sexualActivity.rawValue + 1).localized
    }
    
    func text(for contraception: ContraceptionPills) -> String {
        return String(format: "contraception_pill_%d", contraception.rawValue + 1).localized
    }
    
    func textList(for contraception: ContraceptionPills) -> String {
        return String(format: "contraception_pill_%d_list", contraception.rawValue + 1).localized
    }
    
    func text(for contraception: ContraceptionDailyOther) -> String {
        return String(format: "contraception_other_%d", contraception.rawValue + 1).localized
    }
    
    func text(for contraception: ContraceptionIUD) -> String {
        return String(format: "contraception_uid_%d", contraception.rawValue + 1).localized
    }
    
    func textList(for contraception: ContraceptionIUD) -> String {
        return String(format: "contraception_uid_%d_list", contraception.rawValue + 1).localized
    }
    
    func text(for contraception: ContraceptionImplant) -> String {
        return String(format: "contraception_implant_%d", contraception.rawValue + 1).localized
    }
    
    func textList(for contraception: ContraceptionImplant) -> String {
        return String(format: "contraception_implant_%d_list", contraception.rawValue + 1).localized
    }
    
    func text(for contraception: ContraceptionPatch) -> String {
        return String(format: "contraception_patch_%d", contraception.rawValue + 1).localized
    }
    
    func textList(for contraception: ContraceptionPatch) -> String {
        return String(format: "contraception_patch_%d_list", contraception.rawValue + 1).localized
    }
    
    func text(for contraception: ContraceptionRing) -> String {
        return String(format: "contraception_ring_%d", contraception.rawValue + 1).localized
    }
    
    func textList(for contraception: ContraceptionRing) -> String {
        return String(format: "contraception_ring_%d_list", contraception.rawValue + 1).localized
    }
    
    func text(for contraception: ContraceptionLongTermOther) -> String {
        return "icon_contraception_injection".localized
    }
    
    func text(for contraception: ContraceptionShot) -> String {
        return "shot_list".localized
    }
    
    func textList(for contraception: ContraceptionShot) -> String {
        return "shot_list".localized
    }
    
    func text(for test: TestPregnancy) -> String {
        return String(format: "test_pregnancy_%d", test.rawValue + 1).localized
    }
    
    func textList(for test: TestPregnancy) -> String {
        return String(format: "test_pregnancy_%d_list", test.rawValue + 1).localized
    }
    
    func text(for test: TestSTI) -> String {
        return String(format: "test_sti_%d", test.rawValue + 1).localized
    }
    
    func textList(for test: TestSTI) -> String {
        return String(format: "test_sti_%d_list", test.rawValue + 1).localized
    }
    
    //MARK: - Image Methods
    
    func image(for bleedingSize: BleedingSize) -> String {
        switch bleedingSize {
        case .heavy:
            return "IconBleedingHeavy"
        case .light:
            return "IconBleedingLight"
        case .medium:
            return "IconBleedingMedium"
        case .spoting:
            return "IconBleedingSpotting"
        }
    }
	
	func image(for bleedingClot: BleedingClot) -> String {
		switch bleedingClot {
		case .small:
			return "IconBleedingSmallClots"
		case .big:
			return "IconBleedingBigClots"
		}
	}
    
    func image(for bleedingProducts: BleedingProducts) -> String {
        switch bleedingProducts {
        case .reusablePad:
            return "IconMenstruation1"
        case .disposablePad:
            return "IconMenstruation2"
        case .tampon:
            return "IconMenstruation3"
        case .menstrualCup:
            return "IconMenstruation4"
        case .menstrualDisc:
            return "IconMenstruation5"
        case .periodUnderwear:
            return "IconMenstruation6"
        case .liner:
            return "IconMenstruation7"
        case .pad:
           return "IconMenstruation1"
        }
    }
    
    func image(for emotions: Emotions) -> String {
        switch emotions {
        case .calm:
            return "iconEmotionsCalm"
        case .stressed:
            return "iconEmotionsStressed"
        case .unmotivated:
            return "iconEmotionsUnmotivated"
        case .sad:
            return "iconEmotionsSad"
        case .happy:
            return "iconEmotionsHappy"
        case .irritable:
            return "iconEmotionsIrritable"
        case .angry:
            return "iconEmotionsAngry"
        case .energetic:
            return "iconEmotionsEnergetic"
        case .horny:
            return "IconEmotionsHorny"
        }
    }
    
    func image(for body: Body) -> String {
        switch body {
        case .acne:
            return "IconBodyAcne"
        case .bloating:
            return "IconBodyBloating"
        case .cramps:
            return "IconBodyCramps"
        case .cravings:
            return "IconBodyCravings"
        case .discharge:
            return "IconBodyDischarge"
        case .fatigue:
            return "IconBodyFatigue"
        case .fever:
            return "IconBodyFever"
        case .headache:
            return "IconBodyHeadache"
        case .itchy:
            return "IconBodyItchy"
        case .nausea:
            return "IconBodyNausea"
        case .severePain:
            return "IconBodySeverepain"
        case .stomachache:
            return "IconBodyStomachache"
        case .tenderBreasts:
            return "IconBodyTenderbreasts"
        case .ovulation:
            return "IconBodyOvulation"
        }
    }
    
    func image(for sexualActivity: SexualProtectionSTI) -> String {
        switch sexualActivity {
        case .protected:
            return "iconProtectionStiProtected"
        case .unprotected:
            return "iconProtectionStiUnprotected"
        }
    }
    
    func image(for sexualActivity: SexualProtectionOther) -> String {
        switch sexualActivity {
        case .masturbation:
            return "iconProtectionOtherMasturbation"
        case .oralSex:
            return "iconProtectionOtherOralSex"
        case .orgasm:
            return "iconProtectionOtherOrgasm"
        case .sexToys:
            return "iconProtectionOtherSexToys"
        case .analSex:
            return "iconProtectionOtherAnalSex"
        }
    }
    
    func image(for sexualActivity: SexualProtectionPregnancy) -> String {
        switch sexualActivity {
        case .protected:
            return "iconProtectionPregnancyProtected"
        case .unprotected:
            return "iconProtectionPregnancyUnprotected"
        }
    }
    
    func image(for contraception: ContraceptionPills) -> String {
        switch contraception {
        case .double:
            return "IconContraceptionPillDouble"
        case .missed:
            return "IconContraceptionPillMissed"
        case .took:
            return "IconContraceptionPillTook"
        }
    }
    
    func image(for contraception: ContraceptionDailyOther) -> String {
        switch contraception {
        case .cervicalCup:
            return "IconContraceptionCervicalcup"
        case .condom:
            return "IconContraceptionCondom"
        case .diaphragm:
            return "IconContraceptionDiaphragm"
        case .emergency:
            return "IconContraceptionEmergency"
        case .spermicide:
            return "IconContraceptionSpermicide"
        case .sponge:
            return "IconContracetionSponge"
        case .withdrawal:
            return "IconContraceptionWithdrawal"
        }
    }
    
    func image(for contraception: ContraceptionIUD) -> String {
        switch contraception {
        case .checkedStrings:
            return "IconContraceptionIudChecked"
        case .new:
            return "IconContraceptionIudNew"
        case .removed:
            return "IconContraceptionIudRemoved"
        }
    }
    
    func image(for contraception: ContraceptionImplant) -> String {
        switch contraception {
        case .new:
            return "IconContraceptionImplantNew"
        case .removed:
            return "IconContraceptionImplantRemoved"
        }
    }
    
    func image(for contraception: ContraceptionPatch) -> String {
        switch contraception {
        case .new:
            return "IconContraceptionPatchNew"
        case .removed:
            return "IconContraceptionPatchRemoved"
        }
    }
    
    func image(for contraception: ContraceptionRing) -> String {
        switch contraception {
        case .new:
            return "IconContraceptionRingNew"
        case .removed:
            return "IconContraceptionRingRemoved"
        }
    }
    
    func image(for contraception: ContraceptionLongTermOther) -> String {
        switch contraception {
        case .injection:
            return "IconContraceptionInjection"
        }
    }
    
    func image(for contraception: ContraceptionShot) -> String {
        switch contraception {
        case .shot:
            return "IconContraceptionShot"
        }
    }
    
    func image(for test: TestSTI) -> String {
        switch test {
        case .negative:
            return "testStiNegative"
        case .positive:
            return "testStiPositive"
        }
    }
    
    func image(for test: TestPregnancy) -> String {
        switch test {
        case .negative:
            return "testPregnancyNegative"
        case .positive:
            return "testPregnancyPositive"
        }
    }
}
