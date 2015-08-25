/* Copyright (c) 2012 Research In Motion Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "imageloader.hpp"

#include "imageprocessor.hpp"

#include <bb/ImageData>
#include <QUrl>
#include <QDebug>

ImageLoader::ImageLoader
	(
		const QString &param1,
		const QString &param2,
		const QString &param3,
		const QString &param4,
		const QString &param5,
		const QString &param6,
		const QString &param7,
		const QString &param8,
		const QString &param9,
		const QString &param10,
		const QString &param11,
		const QString &param12,
		const QString &param13,
		const QString &param14,
		const QString &param15,
		const QString &param16,
		const QString &param17,
		const QString &param18,
		const QString &param19,
		const QString &param20,
		const QString &param21,
		const QString &param22,
		QObject* parent
	)
    : QObject(parent)
{
	m_loading = false;
	emit loadingChanged();

	//id
	m_param1 = param1;
	emit param1Changed();

	//
	m_param2 = param2;
	emit param2Changed();

	//
	m_param3 = param3;
	emit param3Changed();

	//
	m_param4 = param4;
	emit param4Changed();

	//
	m_param5 = param5;
	emit param5Changed();

	//
	m_param6 = param6;
	emit param6Changed();

	//
	m_param7 = param7;
	emit param7Changed();

	//
	m_param8 = param8;
	emit param8Changed();

	//
	m_param9 = param9;
	emit param9Changed();

	//
	m_param10 = param10;
	emit param10Changed();

	//
	m_param11 = param11;
	emit param11Changed();

	//
	m_param12 = param12;
	emit param12Changed();

	//
	m_param13 = param13;
	emit param13Changed();

	//
	m_param14 = param14;
	emit param14Changed();

	//
	m_param15 = param15;
	emit param15Changed();

	//
	m_param16 = param16;
	emit param16Changed();

	//
	m_param17 = param17;
	emit param17Changed();

	//
	m_param18 = param18;
	emit param18Changed();

	//
	m_param19 = param19;
	emit param19Changed();

	//
	m_param20 = param20;
	emit param20Changed();

	//
	m_param21 = param21;
	emit param21Changed();

	//
	m_param22 = param22;
	emit param22Changed();
}

ImageLoader::~ImageLoader() { }

QString ImageLoader::getUsername(){
	return m_param9;
}

void ImageLoader::load()
{
    m_loading = true;
    emit loadingChanged();

    QNetworkAccessManager* netManager = new QNetworkAccessManager(this);

    const QUrl url(m_param5); // imageURL
    QNetworkRequest request(url);

    QNetworkReply* reply = netManager->get(request);
    connect(reply, SIGNAL(finished()), this, SLOT(onReplyFinished()));
}

void ImageLoader::onReplyFinished()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

    QString response;
    if (reply)
    {
        if (reply->error() == QNetworkReply::NoError)
        {
            const int available = reply->bytesAvailable();
            if (available > 0)
            {
                const QByteArray data(reply->readAll());

                // Setup the image processing thread
                ImageProcessor *imageProcessor = new ImageProcessor(data);

                QFuture<QImage> future = QtConcurrent::run(imageProcessor, &ImageProcessor::start);

                // Invoke our onProcessingFinished slot after the processing has finished.
                connect(&m_watcher, SIGNAL(finished()), this, SLOT(onImageProcessingFinished()));

                // starts watching the given future
                m_watcher.setFuture(future);
            }
        }
        else
        {
            m_loading = false;
            emit loadingChanged();
        }

        reply->deleteLater();
    }
    else
    {
        m_loading = false;
        emit loadingChanged();
    }
}

void ImageLoader::onImageProcessingFinished()
{
    const QImage swappedImage = m_watcher.future().result().rgbSwapped();
    const bb::ImageData imageData = bb::ImageData::fromPixels(swappedImage.bits(), bb::PixelFormat::RGBX, swappedImage.width(), swappedImage.height(), swappedImage.bytesPerLine());

    m_image = bb::cascades::Image(imageData);
    emit imageChanged();

    m_loading = false;
    emit loadingChanged();
}

bool ImageLoader::loading() const
{
    return m_loading;
}

QVariant ImageLoader::image() const
{
    return QVariant::fromValue(m_image);
}

// ------------------------------ 1 ------------------------------------- //

QString ImageLoader::id() const
{
    return m_param1;
}

// ------------------------------ 2 ------------------------------------- //

QString ImageLoader::pending() const
{
    return m_param2;
}

// ------------------------------ 3 ------------------------------------- //

QString ImageLoader::enabled() const
{
    return m_param3;
}

// ------------------------------ 4 ------------------------------------- //

QString ImageLoader::datetime() const
{
    return m_param4;
}

// ------------------------------ 5 ------------------------------------- //

QString ImageLoader::picture() const
{
    return m_param5;
}

// ------------------------------ 6 ------------------------------------- //

QString ImageLoader::itemid() const
{
    return m_param6;
}

QString ImageLoader::name() const
{
    return m_param6;
}

QString ImageLoader::status() const
{
    return m_param6;
}

// ------------------------------ 7 ------------------------------------- //

QString ImageLoader::itemtype() const
{
    return m_param7;
}

QString ImageLoader::branchname() const
{
    return m_param7;
}

QString ImageLoader::storeid() const
{
    return m_param7;
}

// ------------------------------ 8 ------------------------------------- //

QString ImageLoader::address() const
{
    return m_param8;
}

QString ImageLoader::description() const
{
    return m_param8;
}

QString ImageLoader::userid() const
{
    return m_param8;
}

// ------------------------------ 9 ------------------------------------- //

QString ImageLoader::longitude() const
{
    return m_param9;
}

QString ImageLoader::price() const
{
    return m_param9;
}

QString ImageLoader::username() const
{
    return m_param9;
}

// ------------------------------ 10 ------------------------------------- //

QString ImageLoader::latitude() const
{
    return m_param10;
}

QString ImageLoader::producttypeid() const
{
    return m_param10;
}

QString ImageLoader::review() const
{
    return m_param10;
}

// ------------------------------ 11 ------------------------------------- //

QString ImageLoader::telnum() const
{
    return m_param11;
}

QString ImageLoader::comment() const
{
    return m_param11;
}

// ------------------------------ 12 ------------------------------------- //

QString ImageLoader::deliverynum() const
{
    return m_param12;
}

// ------------------------------ 13 ------------------------------------- //

QString ImageLoader::email() const
{
    return m_param13;
}

// ------------------------------14 ------------------------------------- //

QString ImageLoader::storetypeid() const
{
    return m_param14;
}

// ------------------------------ 15 ------------------------------------- //

QString ImageLoader::distance() const
{
    return m_param15;
}

// ------------------------------ 16 ------------------------------------- //

QString ImageLoader::ratings() const
{
    return m_param16;
}

// ------------------------------ 17 ------------------------------------- //

QString ImageLoader::trafficlevel() const
{
    return m_param17;
}

// ------------------------------ 18 ------------------------------------- //

QString ImageLoader::averagestatus() const
{
    return m_param18;
}

// ------------------------------ 19 ------------------------------------- //

QString ImageLoader::trafficcount() const
{
    return m_param19;
}

// ------------------------------ 20 ------------------------------------- //

QString ImageLoader::lasttrafficdatetime() const
{
    return m_param20;
}

// ------------------------------ 21 ------------------------------------- //

QString ImageLoader::facebookid() const
{
    return m_param21;
}

// ------------------------------ 22 ------------------------------------- //

QString ImageLoader::twitterid() const
{
    return m_param22;
}

// ------------------------------ EXTRAS ------------------------------------- //

QString ImageLoader::website() const
{
    return "";
}
