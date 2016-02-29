//
//  WeiboDetailVC.m
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/9.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import "WeiboDetailVC.h"
#import "GridView.h"
#import "NSString+Expand.h"
#import "WeiboDetailCell.h"
#import "NSMutableDictionary+Extend.h"
#import "CommentHeadBtn.h"
#import "CommentCell.h"
#import "MJRefresh.h"
#import "URRequest.h"
#import "UIViewController+Expand.h"

@interface WeiboDetailVC ()
{
    UITableView *m_tableView;
    WeiboEntity *m_entity;
    NSMutableArray *m_dataArr;
    CommentHeadBtn *reportBtn;
    CommentHeadBtn *commentBtn;
    CommentHeadBtn *praiseBtn;
    NSInteger page;
    NSInteger totalPage;
    BOOL isLoadMore;
}
@end

@implementation WeiboDetailVC

- (void)onBackButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
    [[URRequest sharedURRequest] cancelRequestWithOperationId:kRequestCommentsListTag];
}

#pragma mark - life cycle
- (instancetype)initWithEntity:(WeiboEntity *)entity
{
    if(self = [super init])
    {
        m_entity = entity;
        page = 1;
    }
    return self;
}

- (UIView *)mainContentView
{
    UIView *mainView = [[UIView alloc]initWithFrame:self.mainContentViewFrame];
    mainView.backgroundColor = [UIColor whiteColor];
    
    m_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.mainContentViewFrame.size.width, self.mainContentViewFrame.size.height)];
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.backgroundColor = [UIColor colorWithHex:0xf2f2f2];
    [mainView addSubview:m_tableView];
    
    __weak WeiboDetailVC *weakSelf = self;
    
    [m_tableView addLegendFooterWithRefreshingBlock:^{
        page += 1;
        isLoadMore = YES;
        [weakSelf requestCommentsList];
    }];
    
    [m_tableView addLegendHeaderWithRefreshingBlock:^{
        page = 1;
        isLoadMore = NO;
        [weakSelf requestCommentsList];
    }];
    
    m_tableView.header.updatedTimeHidden = YES;
    m_tableView.footer.hidden = YES;
    
    return mainView;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navTitle = @"微博正文";
    
    [self requestCommentsList];
}

#pragma mark - tableview datasouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section==0)?1:m_dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        float textHeight = [m_entity.weiboText getHeightByWidth:kScreenWith-20 font:WeiboTextFont];
        NSString *retweetStr = [NSString stringWithFormat:@"@%@ %@", m_entity.retweeted_status.user.name,m_entity.retweeted_status.weiboText];
        float retweetHeight = [retweetStr getHeightByWidth:kScreenWith-20 font:RetweetWeiboTextFont]+10;
        
        return 50+textHeight+(m_entity.retweeted_status?retweetHeight+31+([GridView getDetailGridViewHeight:m_entity.retweeted_status]+20):[GridView getDetailGridViewHeight:m_entity]+21);
    }
    else
    {
        Comment *comment = m_dataArr[indexPath.row];
        float contentTextHeight = [comment.text getHeightByWidth:kScreenWith-50-20 font:SystemFont_14];

        return 50+contentTextHeight+10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        WeiboDetailCell *cell = [[WeiboDetailCell alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell layoutCellWithEntity:m_entity];
        
        return cell;
    }
    else
    {
        static NSString *cellIdentify = @"cellIdentify";
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if(cell == nil)
        {
            cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        Comment *comment = m_dataArr[indexPath.row];
        [cell layoutWithEntity:comment];
        
        return cell;
    }
}

#pragma mark - tableview delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 1)
    {
        UIView *sectionHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, 40)];
        sectionHeadView.backgroundColor = [UIColor whiteColor];
        
        UIView *spaceView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, 10)];
        spaceView.backgroundColor = [UIColor colorWithHex:0xf2f2f2];
        [sectionHeadView addSubview:spaceView];
        
        UIView *toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenWith, 30)];
        toolView.backgroundColor = [UIColor clearColor];
        [sectionHeadView addSubview:toolView];
        
        reportBtn = [[CommentHeadBtn alloc]init];
        commentBtn = [[CommentHeadBtn alloc]init];
        praiseBtn = [[CommentHeadBtn alloc]init];
        [toolView addSubview:reportBtn];
        [toolView addSubview:commentBtn];
        [toolView addSubview:praiseBtn];
        
        [reportBtn setLeftText:@"转发" rightText:[NSString stringWithFormat:@"%lu",m_entity.reposts_count]];
        [commentBtn setLeftText:@"评论" rightText:[NSString stringWithFormat:@"%lu",m_entity.comments_count]];
        [praiseBtn setLeftText:@"赞" rightText:[NSString stringWithFormat:@"%lu",m_entity.attitudes_count]];

        reportBtn.frame = CGRectMake(0, 0, reportBtn.width, 30);
        commentBtn.frame = CGRectMake(reportBtn.x+reportBtn.width, 0, commentBtn.width, 30);
        praiseBtn.frame = CGRectMake(kScreenWith-praiseBtn.width-10, 0, praiseBtn.width, 30);
        
        UIImageView *spaceLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39, kScreenWith, 1)];
        spaceLine.image = [UIImage imageNamed:@"icon_horizontal_line"];
        [sectionHeadView addSubview:spaceLine];
        
        return sectionHeadView;
    }
    else
    {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 0;
    }
    else
    {
        return 40;
    }
}

#pragma mark - 网络请求
- (void)requestCommentsList
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObjectExtra:[SystemSetting getAccesstoken] forKey:@"access_token"];
    [params setObjectExtra:[NSNumber numberWithInteger:m_entity.ID] forKey:@"id"];
    [params setObjectExtra:[NSNumber numberWithInt:kPageCount] forKey:@"count"];
    [params setObjectExtra:[NSNumber numberWithInteger:page] forKey:@"page"];
    
    [[BussinessManager sharedBussinessManager].commentManager requestCommentsList:params success:^(NSMutableArray *resultArr, NSInteger aTotalPage) {

        totalPage = aTotalPage;
        
        if(isLoadMore)
        {//加载更多
            if(page < totalPage)
            {
                [m_dataArr addObjectsFromArray:resultArr];
                m_tableView.footer.hidden = NO;
            }
            else
            {
                page = totalPage;
                m_tableView.footer.hidden = YES;
            }
            
            [m_tableView.footer endRefreshing];
        }
        else
        {//下拉刷新
            if(totalPage == 1)
            {
                m_tableView.footer.hidden = YES;
            }
            else
            {
                m_tableView.footer.hidden = NO;
            }
            
            [m_dataArr removeAllObjects];
            m_dataArr = resultArr;
            [m_tableView.header endRefreshing];
        }
        
        [m_tableView reloadData];
        
    } fail:^(NSString * errorStr) {
        
        if(isLoadMore)
        {
            page--; //网络请求失败，执行减操作，上拉的时候加了1，需要减1，保持当前失败的页码
            [m_tableView.footer setTitle:@"加载失败，点击重试" forState:MJRefreshFooterStateIdle];
        }
        else
        {
            [self hudShowTextOnly:errorStr delay:1.5 view:self.navigationController.view];
        }
        
        [m_tableView.footer endRefreshing];
        [m_tableView.header endRefreshing];
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
