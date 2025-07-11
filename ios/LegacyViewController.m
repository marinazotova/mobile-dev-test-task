// LegacyViewController.m (ARC)
@implementation LegacyViewController {
    NSMutableArray *_dataArray; // Проблема 1: Небезопасный доступ из потоков
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Проблема 2: Смешанная архитектура (MVC с элементами MVP)
    [self loadData];
}

// Проблема 3: Ручная многопоточность
- (void)loadData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://api.example.com/data"]];
        
        // Проблема 4: Гонка данных
        _dataArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Проблема 5: Сильная ссылка на self
            [self.tableView reloadData];
        });
    });
}

// Проблема 6: Отсутствие обработки ландшафтной ориентации
- (BOOL)shouldAutorotate {
    return NO;
}

// Проблема 7: Утечка через блок (retain cycle)
- (void)setupHandlers {
    __weak typeof(self) weakSelf = self;
    self.completionHandler = ^{
        [weakSelf handleComplete];
        self.tableView.backgroundColor = UIColor.redColor; // Ошибка!
    };
}
@end
