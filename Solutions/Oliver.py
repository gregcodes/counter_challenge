from datetime import datetime, timedelta


def group_companies(data):
    data = [d.split(";") for d in data.split("\n")[1:]]
    pairs = [(d[1], d[2][1:-1]) for d in data if len(d) == 3]
    companyDatesMap = {}
    for company, dateStr in pairs:
        date = datetime.strptime(dateStr, "%Y-%m-%d")
        companyDatesMap.setdefault(company, []).append(date)
    return companyDatesMap


class CompanyDataSet:
    def __init__(self, name, dates, days=60):
        self.name = name
        self.dates = sorted(dates)
        self.delta = timedelta(days=days)
        self.validBids = self.count_bids()

    def count_bids(self):
        validBids = 1
        refDate = self.dates.pop(0)
        while self.dates:
            refDate = self.get_next_valid_date(refDate)
            if not refDate:
                break

            validBids += 1
        return validBids

    def get_next_valid_date(self, refDate):
        while self.dates:
            nextDate = self.dates.pop(0)
            if nextDate - refDate > self.delta:
                return nextDate


def measure(data):
    start = datetime.now()
    sets = [CompanyDataSet(k, v) for k, v in group_companies(data).items()]
    durationInMs = (datetime.now() - start).microseconds
    assert sum([e.validBids for e in sets]) == 394
    return durationInMs


if __name__ == '__main__':
    with open('dataset.csv') as f:
        content = f.read()
    durationsInMs = [measure(content) for i in range(1000)]
    print(durationsInMs)
    print("fastest", min(durationsInMs))
    print("avg", sum(durationsInMs) / len(durationsInMs))
    print("slowest", max(durationsInMs))
