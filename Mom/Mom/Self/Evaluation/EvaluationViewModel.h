//
//  EvaluationViewModel.h
//  Mom
//
//  Created by together on 2018/6/7.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"

@interface EvaluationViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand *getTagcommand;

@property (strong, nonatomic) RACCommand *evaluationCommand;

@property (strong, nonatomic) RACSubject *tagRefreshSubject;

@property (strong, nonatomic) RACSubject *backSubject;
@end
